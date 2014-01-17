class CreateMovements < ActiveRecord::Migration
  def change
    create_table :movements do |t|
      t.integer :tape_id
      t.date :date
      t.integer :from_location_id
      t.integer :to_location_id

      t.timestamps
    end
  end
end
