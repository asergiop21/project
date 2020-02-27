class AddColumnProfitToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :profit, :numeric, precision: 10, scale: 2
  end
end
