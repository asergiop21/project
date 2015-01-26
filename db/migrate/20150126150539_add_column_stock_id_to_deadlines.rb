class AddColumnStockIdToDeadlines < ActiveRecord::Migration
  def change
    add_column :deadlines, :stock_id, :integer
  
  end
end
