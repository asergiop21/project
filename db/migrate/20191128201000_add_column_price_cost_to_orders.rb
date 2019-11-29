class AddColumnPriceCostToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :price_cost, :numeric
  end
end
