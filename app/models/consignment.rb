class Transit_validator < ActiveModel::Validator
	def validate(record)
		record.tapes.each do |tape|
			t = Tape.find_by_reference(tape.reference)
			unless t.consignments.count == 0
				if t.consignments.order(updated_at: :desc).first.in_transit == true
					record.errors[:base] << "Tape #{t.reference} is currently in transit and cannot be added to a new consignment"
				end
			end
		end
	end
end

class Consignment < ActiveRecord::Base

	include ActiveModel::Dirty

	auditable

	has_many :contents, :foreign_key => :consignment_id
	has_many :tapes, :through => :contents
	belongs_to :from_location, :class_name => 'Location'
	belongs_to :to_location, :class_name => 'Location'

	validates :security_tag, :uniqueness => { :case_sensitive => false, :allow_nil => true, :allow_blank => true }
	validates_with Transit_validator, :on => :create

end

