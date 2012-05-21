class AddCreatorIdToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :creator_id, :integer
  end
end
