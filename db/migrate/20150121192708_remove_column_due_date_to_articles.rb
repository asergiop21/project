class RemoveColumnDueDateToArticles < ActiveRecord::Migration
  def change
     remove_column :articles, :due_date 
  end
end
