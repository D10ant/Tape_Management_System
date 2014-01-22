class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
    	t.integer :tape_id
    	t.integer :consignments_id

    	t.timestamps
    end
  end
end
