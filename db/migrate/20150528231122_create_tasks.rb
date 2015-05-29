class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :user, index: true, foreign_key: true
      t.text :note
      t.date :created_at
      t.date :completed_at

      t.timestamps null: false
    end
	add_index :tasks, [:user_id, :created_at]
  end
end
