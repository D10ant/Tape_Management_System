class DeleteTapeIdFromConsignments < ActiveRecord::Migration
	def change
		remove_column :consignments, :tape_id
	end
end
