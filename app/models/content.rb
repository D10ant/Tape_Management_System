class Content < ActiveRecord::Base
	belongs_to :consignment
	belongs_to :tape
end