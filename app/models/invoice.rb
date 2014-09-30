class Invoice < ActiveRecord::Base

  has_many :orders 
  belongs_to :customer 

  accepts_nested_attributes_for :orders, :reject_if => lambda {|a| a[:article_id].blank?}


  def self.total
    sum = 0
    
    @invoices = Invoice.where("created_at::date = ?", Date.today) 
    @invoices.each { |a| sum += a.price_total.to_f} 
    sum
  end

  def self.caja_diaria
    @invoices = Invoice.where("created_at::date = ?", Date.today) 
  end

end
