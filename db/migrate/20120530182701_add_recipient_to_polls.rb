class AddRecipientToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :recipient_id, :integer, :null => true, :default => nil
  end
end
