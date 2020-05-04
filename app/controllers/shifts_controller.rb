class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]

  # GET /shifts
  # GET /shifts.json
  def index
    @shifts = Shift.all.paginate(page: params[:page]).per_page(4)
    @upcoming_shifts = Shift.upcoming.chronological.paginate(page: params[:page]).per_page(4)
    @unrecorded_shifts = Shift.past.incomplete.chronological.paginate(page: params[:page]).per_page(4)
    @recorded_shifts = Shift.past.completed.chronological.paginate(page: params[:page]).per_page(4)
    @jobs = Job.all.paginate(page: params[:page]).per_page(4)
  end

  # GET /shifts/1
  # GET /shifts/1.json
  def show
  end

  # GET /shifts/new
  def new
    @shift = Shift.new
  end

  # GET /shifts/1/edit
  def edit
  end

  def checked
    #loop through the job in database and see if its in the params hash
    #shift id will be part of params hash
    #with shift id, add it shiftjobs by adding new shiftjob with that shift id
    
    @jobs = Job.all
    puts 'hellooo'
    puts params
    @shift = Shift.find(params[:calvin][:shift_id])
    #@jobs.each do |j|
      #index params for calvin properly
      # take out if statement 
      #shift params needa go thru calvin
    params[:calvin][:job_checkboxes].each do |j|
        @shiftjob = ShiftJob.new
        @shiftjob.job_id = j
        @shiftjob.shift_id = @shift.id
        @shiftjob.save 
      end
  end

  # POST /shifts
  # POST /shifts.json
  def create
    @shift = Shift.new(shift_params)

    respond_to do |format|
      if @shift.save
        format.html { redirect_to @shift, notice: 'Shift was successfully created.' }
        format.json { render :show, status: :created, location: @shift }
      else
        format.html { render :new }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shifts/1
  # PATCH/PUT /shifts/1.json
  def update
    respond_to do |format|
      if @shift.update(shift_params)
        format.html { redirect_to @shift, notice: 'Shift was successfully updated.' }
        format.json { render :show, status: :ok, location: @shift }
      else
        format.html { render :edit }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shifts/1
  # DELETE /shifts/1.json
  def destroy
    @shift.destroy
    respond_to do |format|
      format.html { redirect_to shifts_url, notice: 'Shift was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shift
      @shift = Shift.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shift_params
      params.require(:shift).permit(:assignment_id, :date, :start_time, :notes, :status, :end_time)
    end
end
