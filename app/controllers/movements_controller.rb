class MovementsController < ApplicationController
	before_action :set_movement, only: [:show, :edit, :update, :destroy]

	def index 
		@movements = Inventory.all
	end

	def show

	end

	def edit

	end

	def update
		  render text: params[:movement].inspect
	end

end