class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :tape_id
      t.integer :location_id

      t.timestamps
    end
  end
end
