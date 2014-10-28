class TapesController < ApplicationController
  before_action :set_tape, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  skip_before_filter :verify_authenticity_token

  # GET /tapes
  # GET /tapes.json
  def index
  #  @tapes = Tape.all
      @tapes = Tape.search(params[:search]).paginate(:per_page => 10, :page => params[:page])
  end

  # GET /tapes/1
  # GET /tapes/1.json
  def show
  end

  # GET /tapes/new
  def new
    @tape = Tape.new
    @customers = Customer.all
  end

  # GET /tapes/1/edit
  def edit
    @customers = Customer.all
    @locations = Location.all
  end

  # POST /tapes
  # POST /tapes.json
  def create
    Rails.logger = Logger.new(STDOUT)
    Rails.logger.debug tape_params.inspect
    #@tape = Tape.new(tape_params)

    #!!TODO!! Improve this block of code
    if params["tape"]["reference"].is_a?(Array) || params["tape"]["reference"].is_a?(Hash)
      params["tape"]["reference"].each do |reference|
        unless reference == ''
          @tape = Tape.new(:reference => reference, :customer_id => tape_params['customer_id'])
          @tape.save
        end
      end
    else
      unless params["tape"]["reference"] == ''
        @tape = Tape.new(:reference => params["tape"]["reference"], :customer_id => tape_params['customer_id'])
        @tape.save
      end
    end

    respond_to do |format|
      if @tape.save
        format.html { redirect_to tapes_path, success: "Tape Successfully Added!" }
        format.json { render action: 'show', status: :created, location: @tape }
      else
        format.html { render action: 'new' }
        format.json { render json: @tape.errors, status: :unprocessable_entity }
      end
    end

    #@location = Location.all
    #@customer = Customer.all

    #location_match = consignment_validation(params["tapes"])

    #@consignment.errors

    #!!TODO!! Figure out a way to write this better. Not Dry.
    #respond_to do |format|
    #  if location_match != false
    #    if @consignment.save
    #      format.html { redirect_to consignments_path, success: "Consignment Successfully Created!" }
    #      format.json { render action: 'show', status: :created, location: @consignment }
    #    else
    #      format.html { render action: 'new' }
    #      format.json { render json: @consignment.errors, status: :unprocessable_entity }
    #    end
    #  else
    #    format.html { render action: 'new' }
    #    format.json { render json: @consignment.errors, status: :unprocessable_entity }
    #  end
    #end





    #@tape = Tape.new(tape_params)

    #respond_to do |format|
    #  if @tape.save
    #    format.html { redirect_to @tape, notice: 'Tape was successfully created.' }
    #    format.json { render action: 'show', status: :created, location: @tape }
    #  else
    #    format.html { render action: 'new' }
    #    format.json { render json: @tape.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /tapes/1
  # PATCH/PUT /tapes/1.json
  def update

    @consignment = Consignment.new(
      :from_location_id => Tape.find_by_id(params[:id]).location.id,
      :to_location_id => params[:tape][:location],
      :in_transit => false
    )
    @consignment.save

    @content = Content.new(
      :tape_id => params[:id],
      :consignment_id => @consignment.id,
    )
    @content.save

    respond_to do |format|
      if @tape.update(tape_params)
        format.html { redirect_to @tape, notice: 'Tape was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tape.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tapes/1
  # DELETE /tapes/1.json
  def destroy
    @tape.deleted_by = current_user.email
    @tape.save
    @tape.destroy
    respond_to do |format|
      format.html { redirect_to tapes_url }
      format.json { head :no_content }
    end
  end

  def import
    Tape.import(params[:file])
    redirect_to root_url, success: "Tapes Imported"
  end

  def deleted
    @tapes = Tape.only_deleted
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tape
      @tape = Tape.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tape_params
      params.require(:tape).permit(:reference, :customer_id)
    end
end
