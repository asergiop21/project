class CreateDeadlines < ActiveRecord::Migration
  def change
    create_table :deadlines do |t|

      t.date :due_date
      t.references :article

      t.timestamps
    end
  end
end
