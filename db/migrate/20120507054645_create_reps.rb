class CreateReps < ActiveRecord::Migration
  def change
    create_table :reps do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
