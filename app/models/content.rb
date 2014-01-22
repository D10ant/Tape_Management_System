class Content < ActiveRecord::Base
	belongs_to :tape
	belongs_to :consignment
end