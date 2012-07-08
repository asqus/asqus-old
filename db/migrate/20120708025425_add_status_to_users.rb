class AddStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status, :string, :null => true
  end
end
