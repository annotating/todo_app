class ChangeTaskCompletedAtToDatetime < ActiveRecord::Migration
  def change
  	change_column :tasks, :completed_at, :datetime
  end
end
