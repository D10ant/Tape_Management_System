class Tape < ActiveRecord::Base
	belongs_to :customer
	has_many :movements
	has_many :consignments, through: :contents

	def location
		Movement.where('tape_id = ?', id).order(date: :desc).first.to_location
	end
end
