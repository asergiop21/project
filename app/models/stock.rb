class Stock < ActiveRecord::Base

  belongs_to :invoice_stock
  belongs_to :article
  has_many :deadlines

  before_save :update_quantity

  after_create :create_due_date 

  validates :quantity, presence: true
  validates :quantity, numericality: true
  
  #accepts_nested_attributes_for :deadlines

  attr_accessor :due_date

  def to_s
    name
  end

  def update_quantity
   
    @article= Article.find(article_id)
    @article.quantity = 0 if @article.quantity.nil?
    quantity_new = 0 if quantity_new.nil?
    quantity_new += @article.quantity
    percentaje = @article.percentaje.to_f 
    price_total_total = ((self.price_cost.to_f * percentaje)/100 + self.price_cost.to_f)
    @article.update_columns quantity: quantity, category_id: category_id, price_total: price_total_total, price_cost: price_cost

  end

  def create_due_date
      @create = Deadline.create(due_date: self.due_date, article_id: article_id )
  end
end
