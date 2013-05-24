class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fname, :string, default: 'First'
    add_column :users, :lname, :string, default: 'Last'
    add_index  :users, :lname
  end
end
