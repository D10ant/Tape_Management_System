class Consignment < ActiveRecord::Base
	has_many :contents, :foreign_key => :consignment_id
	has_many :tapes, :through => :contents
end