class PayGradesController < ApplicationController
  before_action :set_pay_grade, only: [:show, :edit, :update, :destroy]

  # GET /pay_grades
  # GET /pay_grades.json
  def index
    @pay_grades = PayGrade.all
  end

  # GET /pay_grades/1
  # GET /pay_grades/1.json
  def show
  end

  # GET /pay_grades/new
  def new
    @pay_grade = PayGrade.new
  end

  # GET /pay_grades/1/edit
  def edit
  end

  # POST /pay_grades
  # POST /pay_grades.json
  def create
    @pay_grade = PayGrade.new(pay_grade_params)

    respond_to do |format|
      if @pay_grade.save
        format.html { redirect_to @pay_grade, notice: 'Pay grade was successfully created.' }
        format.json { render :show, status: :created, location: @pay_grade }
      else
        format.html { render :new }
        format.json { render json: @pay_grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pay_grades/1
  # PATCH/PUT /pay_grades/1.json
  def update
    respond_to do |format|
      if @pay_grade.update(pay_grade_params)
        format.html { redirect_to @pay_grade, notice: 'Pay grade was successfully updated.' }
        format.json { render :show, status: :ok, location: @pay_grade }
      else
        format.html { render :edit }
        format.json { render json: @pay_grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pay_grades/1
  # DELETE /pay_grades/1.json
  def destroy
    @pay_grade.destroy
    respond_to do |format|
      format.html { redirect_to pay_grades_url, notice: 'Pay grade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pay_grade
      @pay_grade = PayGrade.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pay_grade_params
      params.require(:pay_grade).permit(:level, :active)
    end
end
