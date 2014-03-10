class ConsignmentsController < ApplicationController
	before_action :set_consignment, only: [:show, :edit, :update, :destroy]

	def index 
		@consignments = Consignment.all
		@location = Location.all
		@tapes = Tape.all
	end

	def show

	end

	def edit

	end

	def update
		render text: params[:consignment].inspect
	end

	def create
		@consignment = Consignment.new(consignment_params)
		
		params["tapes"].each do |c|
			t = Tape.find_by_reference(c)
			@consignment.tapes << t if t
		end

		respond_to do |format|
			if @consignment.save
				format.html { redirect_to @consignment, notice: 'Consignment was successfully created.' }
				format.json { render action: 'show', status: :created, location: @consignment }
			else
				format.html { render action: 'new' }
				format.json { render json: @consignment.errors, status: :unprocessable_entity }
			end
		end
	end

	def new
		@consignment = Consignment.new
		@location = Location.all
	end

	def destroy
		@consignment.destroy
		respond_to do |format|
			format.html { redirect_to consignment_url }
			format.json { head :no_content }
		end
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_consignment
    	@consignment = Consignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def consignment_params
    	params.require(:consignment).permit(:consignment_ref, :customer_id, :from_location_id, :to_location_id, :security_tag, :tapes => [])
    end
end
