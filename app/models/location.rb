class Location < ActiveRecord::Base
	has_many :tapes

	has_many :from_locations, :foreign_key => :from_location, :class_name => 'Consignment'
	has_many :to_locations, :foreign_key => :to_location, :class_name => 'Consignment'
end
