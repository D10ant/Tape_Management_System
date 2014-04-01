class Consignment < ActiveRecord::Base

	include ActiveModel::Dirty

	has_many :contents, :foreign_key => :consignment_id
	has_many :tapes, :through => :contents
	belongs_to :from_location, :class_name => 'Location'
	belongs_to :to_location, :class_name => 'Location'

	#validate :ensure_tapes_match,
	#		 :on => :update

	#def ensure_tapes_match
	#	if self.tapes_changed?

	#	end
		#if (self.tapes != self.tapes_was)
		#	errors.add(:tapes, 'Certain tapes are missing from this consignment')
		#end
	#end
end