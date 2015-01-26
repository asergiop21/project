class RemoveColumnDueDateToStocks < ActiveRecord::Migration
  def change
  
      remove_column :stocks, :due_date
  
  end
end
