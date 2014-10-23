class AuditsController < ApplicationController
	def index
		@tape = Tape.find(params[:tape_id])
		@locations = Location.all

		respond_to do |format|
			format.html
			format.csv	
		end
	end

	def show

	end

end