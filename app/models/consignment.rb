class Consignment < ActiveRecord::Base

	include ActiveModel::Dirty

	has_many :contents, :foreign_key => :consignment_id
	has_many :tapes, :through => :contents
	belongs_to :from_location, :class_name => 'Location'
	belongs_to :to_location, :class_name => 'Location'

	#auditable
end