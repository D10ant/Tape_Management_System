class EditContentConsignmentId < ActiveRecord::Migration
  def change
  	change_table :contents do |t|
  		t.rename :consignments_id, :consignment_id
  	end
  end
end
