class Stock < ActiveRecord::Base


  belongs_to :invoice_stock

  attr_accessor :name

  before_save :update_quantity


  def name
#    name = Article.where(id: article_id).pluck(:barcode, :name) if !article_id.nil? 

  end


  def update_quantity
   
    @article= Article.find(article_id)
    @article.quantity = 0 if @article.quantity.nil?
    self.quantity = 0 if self.quantity.nil?
    self.quantity += @article.quantity
    percentaje = @article.percentaje.to_f 
  
    @price_total_current = @article.price_total.to_f 
    
    price_total_total = ((self.price_cost.to_f * percentaje)/100 + self.price_cost.to_f)

    price_total_total = @price_total_current if price_total_total < @price_total_current
 
 @article.update_columns quantity: self.quantity, supplier_id: supplier_id, due_date: due_date, price_total: price_total_total, price_cost: price_cost
   
  end
end
