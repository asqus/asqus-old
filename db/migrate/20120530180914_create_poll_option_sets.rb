class CreatePollOptionSets < ActiveRecord::Migration
  def change
    create_table :poll_option_sets do |t|
      t.string :options_type, :null => false
      t.text :options, :null => false
      t.integer :num_options, :null => false

      t.timestamps
    end
    
    add_column :polls, :poll_option_set_id, :integer, :null => true, :default => nil

  end
end

