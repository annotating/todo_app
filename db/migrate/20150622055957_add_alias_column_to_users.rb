class AddAliasColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :alias, :text
  end
end
