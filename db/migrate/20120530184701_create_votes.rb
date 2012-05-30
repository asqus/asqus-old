class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :poll_option_set_index, :null => false
      t.integer :poll_id, :null => true
      t.integer :voter_id, :null => true

      t.timestamps
    end
  end
end
