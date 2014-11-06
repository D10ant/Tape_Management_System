class AuditsController < ApplicationController
	def index
		@tapes = Tape.where(:customer_id => params[:customer_id])
		@locations = Location.all

		respond_to do |format|
			format.html
			format.csv
		end
	end

	def show

	end

end
