class MovementsController < ApplicationController
	before_action :set_movement, only: [:show, :edit, :update, :destroy]

	def index 
		@movements = Inventory.all
		@location = Location.all
		@tapes = Tape.all
	end

	def show

	end

	def edit

	end

	def update
		  render text: params[:movement].inspect
	end

	def new
		@movement = Movement.new
		@location = Location.all
	end

end