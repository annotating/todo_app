class AddBlurbToUsers < ActiveRecord::Migration
  def change
    add_column :users, :blurb, :text
  end
end
