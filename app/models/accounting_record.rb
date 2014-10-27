class AccountingRecord < ActiveRecord::Base



  scope :by_created_at, lambda {|from, to| where("created_at::date >= ? and created_at::date <= ? ", from, to).order("created_at asc")}

  def self.journal
    @accounting_record = AccountingRecord.where("created_at::date = ?", Date.today) 
  
  end

  def self.find_by_filters(filters)  
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


end
