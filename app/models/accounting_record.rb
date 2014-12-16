class AccountingRecord < ActiveRecord::Base

  scope :by_created_at, lambda {|from, to| where("created_at::date >= ? and created_at::date <= ? ", from, to).order("created_at desc")}

  def self.journal
    @accounting_record = AccountingRecord.where("created_at::date = ?", Date.today).order(created_at: :desc) 

  end

  def self.filters(filters)  
    q = AccountingRecord.all  
    q = by_created_at((filters[:from].to_date), (filters[:to].to_date)) if filters[:from].present? or filters[:to].present?
    q
  end

  def self.credit(invoice)
    sum = 0
    @invoices = invoice
    @invoices.each { |a| sum += a.credit.to_f} 
    sum
  end

  def self.debit(invoice)
    sum = 0
    @invoices = invoice
    @invoices.each { |a| sum += a.debit.to_f} 
    sum
  end
  def self.total
    @invoices = AccountingRecord.where("created_at::date = ?", Date.today).sum(:debit)
  end

  def self.earnings
    sum = 0 
    @earnings = Article.joins(:orders).select('orders.price_total AS price_total', 'articles.price_cost AS price_cost', 'orders.quantity AS quantity').where("orders.created_at::date = ?", Date.today)
    @earnings.each {|a| sum += a.price_total - (a.price_cost * a.quantity)}
    sum

  end
end
