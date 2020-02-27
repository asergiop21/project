class Category < ActiveRecord::Base

  has_many :articles

  def self.total(from='1900-01-01', to=Date.today) 
    Order.joins( article: :category ).
      where( 'orders.created_at::date >= ?' ,from).
      where( 'orders.created_at::date <= ?' ,to).
      group( 'categories.name' ).sum(:profit)
  end
end
