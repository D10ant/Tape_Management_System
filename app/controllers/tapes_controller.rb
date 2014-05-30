class TapesController < ApplicationController
  before_action :set_tape, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  skip_before_filter :verify_authenticity_token

  # GET /tapes
  # GET /tapes.json
  def index
    @tapes = Tape.all
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
  end

  # POST /tapes
  # POST /tapes.json
  def create
    @tape = Tape.new(tape_params)

    respond_to do |format|
      if @tape.save
        format.html { redirect_to @tape, notice: 'Tape was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tape }
      else
        format.html { render action: 'new' }
        format.json { render json: @tape.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tapes/1
  # PATCH/PUT /tapes/1.json
  def update
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
    @tape.destroy
    respond_to do |format|
      format.html { redirect_to tapes_url }
      format.json { head :no_content }
    end
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
