class Category < ActiveRecord::Base

  has_many :articles

  def self.total(from='1900-01-01', to=Date.today) 
    sum = 0 
    @categories = {}

    @earnings = Article.
      joins(:orders, :category).
      select('orders.price_total AS price_total', 'orders.price_cost AS price_cost', 'orders.quantity AS quantity', 'categories.name as categories_name').
      where("orders.created_at::date >= ?" ,from).
      where("orders.created_at::date <= ?" ,to)
    @earnings.each do |a| 
      sum_unit = 0
      a.quantity = 0 if a.quantity.nil?
      a.price_cost = 0 if a.price_cost.nil?
      a.price_total = 0 if a.price_total.nil?
      sum_unit = a.price_total - (a.price_cost * a.quantity)
      if @categories.include? a.categories_name
        @categories[a.categories_name] +=sum_unit.to_f
      else
        @categories[a.categories_name] = sum_unit.to_f
      end
    end
    @categories
  end

  def self.total_con_fecha(date) 
    Category.joins(articles: :orders).where('orders.created_at::date >= ? and orders.created_at::date <= ?', date[:from].to_date, date[:to].to_date ).order(:name).group(:category_id, 'categories.name').sum('orders.price_total')

  end

end
