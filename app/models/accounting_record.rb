class AccountingRecord < ActiveRecord::Base

  scope :by_created_at, lambda {|from, to| where("created_at::date >= ? and created_at::date <= ? ", from, to).order(debit: :desc, created_at: :desc)}

  belongs_to :user


  def self.journal(user_id, role)
    @accounting_record = AccountingRecord.where("created_at::date = ? and user_id =? ", Date.today, user_id).order(debit:  :asc,  created_at: :desc) if role == 'invitado' 
    @accounting_record = AccountingRecord.where("created_at::date = ? ", Date.today).order(debit:  :asc,  created_at: :desc) if role == 'admin' 

    @accounting_record
  end

  def self.journal_users
    @users =  User.where(is_deleted: false) 
    accounting_record = {}
    @users.map { |x,y|
      credit = 0
      debit = 0 
      credit =  AccountingRecord.where("created_at::date = ? and user_id =? ", Date.today, x.id).order(debit:  :asc,  created_at: :desc).sum(:credit).to_f 
      
      debit =  AccountingRecord.where("created_at::date = ? and user_id =? ", Date.today, x.id).order(debit:  :asc,  created_at: :desc).sum(:debit).to_f 
      accounting_record[x] = credit - debit
    }
    accounting_record
  end



  def self.filters(filters)  
    q = AccountingRecord.all  
    q = by_created_at((filters[:from].to_date), (filters[:to].to_date)) if filters[:from].present? or filters[:to].present?
    q
  end

  def self.credit(invoice)
    sum = 0
    @invoices = invoice
    @invoices.each { |a| sum += a.credit.to_f} if !@invoices.nil? 
    sum
  end

  def self.debit(invoice)
    sum = 0
    @invoices = invoice
    @invoices.each { |a| sum += a.debit.to_f} if !@invoices.nil? 
    sum
  end
  def self.total
    @invoices = AccountingRecord.where("created_at::date = ?", Date.today).sum(:debit)
  end

  def self.earnings(date=nil)
    sum = 0 
    
    @from = Date.today 
    @to = Date.today 
    @from = date[:from] if !date.nil?
    @to = date[:to] if !date.nil?

    @earnings = Article.joins(:orders).select('orders.price_total AS price_total', 'articles.price_cost AS price_cost', 'orders.quantity AS quantity').where("orders.created_at::date >= ? and orders.created_at::date <= ?", @from, @to)

    @earnings.each do |a| 
      a.quantity = 0 if a.quantity.nil?
      a.price_cost = 0 if a.price_cost.nil?
      a.price_total = 0 if a.price_total.nil?
      sum += a.price_total - (a.price_cost * a.quantity)
    end
    sum
  end
end
