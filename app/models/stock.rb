class Stock < ActiveRecord::Base


  belongs_to :invoice_stock

  attr_accessor :name

  before_save :update_quantity


  def update_quantity
   
    @quantity_current = Article.find(article_id)
    @quantity_current.quantity = 0 if @quantity_current.quantity.nil?
    self.quantity = 0 if self.quantity.nil?
    
    self.quantity += @quantity_current.quantity
    @quantity_current.update_columns quantity: self.quantity, supplier_id: supplier_id
   
  end
end
