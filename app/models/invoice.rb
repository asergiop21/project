class Invoice < ActiveRecord::Base

  has_many :orders 
  belongs_to :customer 
  
  accepts_nested_attributes_for :orders, :reject_if => lambda {|a| a[:article_id].blank?}

  scope :by_created_at, lambda {|from, to| where("created_at::date >= ? and created_at::date <= ? ", from, to).order("created_at asc")}
  delegate :name, :lastname,  to: :customer, prefix: true, allow_nil: true
  after_create :create_accounting_record
  
  def self.find_by_filters(filters)  
  
  q = Invoice.all  
  q = by_created_at((filters[:from].to_date), (filters[:to].to_date)) if filters[:from].present? or filters[:to].present?
  q
end


  def self.total
    @invoices = Invoice.where("created_at::date = ?", Date.today).sum(:price_total)
  end

  def self.subtotal(invoice)
    sum = 0
    @invoices = invoice
    @invoices.each { |a| sum += a.price_total.to_f} 
    sum
  end
  def self.caja_diaria
    @invoices = Invoice.where("created_at::date = ?", Date.today) 
  end

  def create_accounting_record
      
      @record = AccountingRecord.create(detail: "Invoice #{id} " , credit: price_total)

  end
end
