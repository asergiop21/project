class AddColumnAllowChangePriceToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :allow_change_price, :boolean, default: false
  
  end
end
