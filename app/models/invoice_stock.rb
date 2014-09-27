class InvoiceStock < ActiveRecord::Base

  has_many :stocks


  accepts_nested_attributes_for :stocks, :reject_if => lambda {|a| a[:article_id].blank?}

end
