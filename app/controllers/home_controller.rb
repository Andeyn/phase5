class HomeController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  before_action :check_login

  def index
  	@active_stores = Store.active.alphabetical.paginate(page: params[:page]).per_page(5)
    @inactive_stores = Store.inactive.alphabetical.paginate(page: params[:ipage]).per_page(5)
    @employees = Employee.active.all
    @jobs = Job.all.paginate(page: params[:page]).per_page(5)

    if logged_in? && (current_employee.role?(:manager) || current_employee.role?(:employee))
      @man_shifts = current_employee.assignments.current.first.store.shifts.paginate(page: params[:page]).per_page(5)

    end 
    if logged_in? && (current_employee.role?(:manager))
      @unrecorded_shifts = Shift.past.incomplete.chronological.paginate(page: params[:page]).per_page(5)

      @store_employees = current_employee.assignments.current.first.store.employees.paginate(page: params[:page]).per_page(5)
    end 
    @active_managers = Employee.managers.active.alphabetical.paginate(page: params[:page]).per_page(5)
    @active_employees = Employee.regulars.active.alphabetical.paginate(page: params[:page]).per_page(5)
    @inactive_employees = Employee.inactive.alphabetical.paginate(page: params[:page]).per_page(5)
  end

  def about
  end

  def contact
  end

  def privacy
  end

  def search
    redirect_back(fallback_location: home_path) if params[:query].blank?
    @query = params[:query]
    @employees = Employee.search(@query)
  end


end