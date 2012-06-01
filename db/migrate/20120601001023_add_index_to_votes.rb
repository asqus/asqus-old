class AddIndexToVotes < ActiveRecord::Migration
  def change
    add_index :votes, [:poll_id, :voter_id], :unique => true
  end
end
