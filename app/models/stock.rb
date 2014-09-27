class Stock < ActiveRecord::Base


  belongs_to :invoice_stock
  
  attr_accessor :name

end
