class Consignment < ActiveRecord::Base
	has_many :tapes, through: :content
end