class Invoice < ActiveRecord::Base

  has_many :orders 
  
  accepts_nested_attributes_for :orders, :reject_if => lambda {|a| a[:article_id].blank?}


end
