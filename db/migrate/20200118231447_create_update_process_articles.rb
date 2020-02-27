class CreateUpdateProcessArticles < ActiveRecord::Migration
  def change
    create_table :update_process_articles do |t|
      t.references :supplier, index: true
      t.integer :updated
      t.integer :failed
      t.references :user, index: true
      t.float :percentage, precision: 8, scale: 2

      t.timestamps
    end
  end
end
