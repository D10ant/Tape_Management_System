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
		@location = Location.all
	end

	def update
		#render text: params[:consignment].inspect
		tapes = Array.new

		@location = Location.all

		@consignment.tapes.each do |tape|
			tapes << tape.reference
		end

		unless params["tapes"].nil?
			missing_tapes = tapes - params["tapes"]
			unknown_tapes = params["tapes"] - tapes
		end

		unless missing_tapes.nil?
			if missing_tapes.empty? && unknown_tapes.empty?

				consignment_params = {"in_transit" => "f"}

				respond_to do |format|
					if @consignment.update(consignment_params)
						format.html { redirect_to consignments_path, success: 'Tape was successfully updated.' }
						format.json { head :no_content }
					else
						format.html { render action: 'edit' }
						format.json { render json: @consignment.errors, status: :unprocessable_entity }
					end
				end
			else
				@consignment.errors["tapes"] = "Do not match. The following tapes are missing/shouldn't be in the consignment. Missing Tapes: #{missing_tapes.join(", ")}. Unknown Tapes: #{unknown_tapes.join(", ")}"
				render 'edit'
			end
		end
		
	end

	def create
		@consignment = Consignment.new(consignment_params)

		@location = Location.all
		@customer = Customer.all
		
		location_match = consignment_validation(params["tapes"])

		@consignment.errors

		#!!TODO!! Figure out a way to write this better. Not Dry. 
		respond_to do |format|
			if location_match != false
				if @consignment.save
					format.html { redirect_to consignments_path, success: "Consignment Successfully Created!" }
					format.json { render action: 'show', status: :created, location: @consignment }
				else
					format.html { render action: 'new' }
					format.json { render json: @consignment.errors, status: :unprocessable_entity }
				end	
			else
				format.html { render action: 'new' }
				format.json { render json: @consignment.errors, status: :unprocessable_entity }
			end
		end
	end

	def new
		@consignment = Consignment.new
		@location = Location.all
		@customer = Customer.all
	end

	def destroy
		@consignment.destroy
		respond_to do |format|
			format.html { redirect_to consignment_url }
			format.json { head :no_content }
		end
	end

	def transit
		@@transit = [params[:transit]]
	end

	def checktape
		@tape = Tape.find_by_reference(params[:tape])
		if @tape
			render :text => true, :layout => false
		elsif params[:tape].blank?
			render :text => true, :layout => false
		else
			render :text => false, :layout => false
		end
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_consignment
    	@consignment = Consignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def consignment_params
    	params.require(:consignment).permit(:consignment_ref, :customer_id, :from_location_id, :to_location_id, :security_tag, :in_transit, :tapes => [])
    end

    def consignment_validation(tapes)
    	location_match = true
    	tapes.each do |c|
			t = Tape.find_by_reference(c)
			@consignment.tapes << t if t

			unless t.consignments.count == 0
				if @consignment.from_location_id != nil && @consignment.from_location_id != t.consignments.order(updated_at: :desc).first.to_location_id
					location_match = false
					@consignment.errors.add(:tapes, "Current locations do not match")
				end
			end

			if t.consignments.count != 0
				@consignment.from_location_id = t.consignments.order(updated_at: :desc).first.to_location_id
			else
				@consignment.from_location_id = 17
			end
		end

		location_1 = @consignment.from_location.location.split(' - ')
		location_2 = @consignment.to_location.location.split(' - ')

		if location_1[0] == location_2[0]
			@consignment.in_transit = false
		else 
			@consignment.in_transit = true
		end

		unless location_1[0] == location_2[0]
			if @consignment.security_tag == ""
				location_match = false
				@consignment.errors.add(:security_tag, "cannot be blank when moving from sites.") 
			end
		end

		if @consignment.from_location_id == @consignment.to_location_id
			@consignment.errors.add(:tapes, "already at this location.")
			location_match = false
		end

		return location_match
    end
end