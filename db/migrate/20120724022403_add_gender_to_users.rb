class AddGenderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :string, :null => true
  end
end
