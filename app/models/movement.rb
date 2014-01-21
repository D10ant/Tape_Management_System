class Movement < ActiveRecord::Base
	belongs_to :tape
	belongs_to :from_location, :class_name => "Location"
	belongs_to :to_location, :class_name => "Location"

	#after_create :do_inventory_update

	#private
	#	def inventory_update
	#		status = self.to_location_id
	#		Inventory.update_attributes(:location_id => status)
	#	end
end
