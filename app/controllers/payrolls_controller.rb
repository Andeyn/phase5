class PayrollsController < ApplicationController
	def new
		@store = Store.find(params[:id])
		@store_emp = Store.find(params[:id]).employees.alphabetical.paginate(page: params[:ipage]).per_page(4)
		@start_date = nil
		@end_date = nil
	end 

	def emp
		@employee = Employee.find(params[:id])
	end

	def show
		#if checkbox for two weeks is sent in, then set starting = 14 days ago
		#so i dont needa send in the info via view
	
	if params[:commit] == "Two Weeks"
		start_date = 14.days.ago.to_date
	 	end_date = Date.current
	elsif params[:commit] == "One Month"
		start_date = 14.days.ago.to_date
	 	end_date = Date.current
	else
		start_date = params[:starting].to_date
		end_date = params[:ending].to_date
	end
		@start_date = start_date
		@end_date = end_date

		@store = Store.find(params[:id])
		@store_emp = Store.find(params[:id]).employees.alphabetical.paginate(page: params[:ipage]).per_page(4)
		date_range = DateRange.new(start_date, end_date)
		calc = PayrollCalculator.new(date_range)
		# calc.store

		@employees = @store.employees
		# TO DO: define here @payroll, etc.
		
		render action: 'show'
	end

	def emp_pay
		unless params[:set_start].nil?
		 	start_date = params[:set_start].days.ago
		 	end_date = Date.current
		else
			start_date = params[:starting].to_date
			end_date = params[:ending].to_date
		end

		emp = Employee.find(params[:id])
		date_range = DateRange.new(14.days.ago)
		calc = PayrollCalculator.new(date_range)

		render action: 'show'
	end
end 