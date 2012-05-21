class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :title
      t.text :prompt
      t.string :category
      t.boolean :published

      t.timestamps
    end
  end
end
