class AuditsController < ApplicationController
	def index
		@tape = Tape.find(params[:tape_id])
		@locations = Location.all
	end

	def show

	end

end