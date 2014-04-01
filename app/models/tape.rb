class Tape < ActiveRecord::Base
	belongs_to :customer
	has_many :movements
	has_many :locations, :through => :consignments, :source => :to_location
	has_many :contents, :foreign_key => :tape_id
	has_many :consignments, :through => :contents
	#def location
	#	Consignment.where('tape_id = ?', id).order(date: :desc).first.to_location
	#end
end
