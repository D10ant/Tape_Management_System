class CreateConsignments < ActiveRecord::Migration
  def change
    create_table :consignments do |t|
    	t.integer :from_location_id
    	t.integer :to_location_id
    	t.integer :tape_id
    	t.text :security_tag

    	t.timestamps
    end
  end
end
