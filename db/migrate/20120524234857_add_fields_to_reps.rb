class AddFieldsToReps < ActiveRecord::Migration
  def change
    add_column :reps, :title, :string
    add_column :reps, :state_id, :integer
    add_column :reps, :district, :string
    add_column :reps, :chamber, :string
    add_column :reps, :level, :string
  end
end
