Rails.application.routes.draw do

  # Semi-static page routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  get 'home/search', to: 'home#search', as: :search

  # Resource routes (maps HTTP verbs to controller actions automatically):
  resources :employees
  resources :stores
  resources :assignments
  resources :sessions
  resources :pay_grade_rates
  resources :pay_grades
  resources :jobs
  resources :shift_jobs
  resources :shifts


  get 'employee/edit' => 'employees#edit', :as => :edit_current_employee
  get 'signup' => 'employees#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout


  get 'jobs/:id' => 'jobs#show', :as => :show_jobs
  get 'jobs/:id' => 'jobs#destroy', :as => :delete_jobs
  ## PAYROLL
  get 'stores/:id/payroll' => 'payrolls#new', :as => :store_payroll
  get 'employees/:id/payroll' => 'payrolls#emp_pay', :as => :emp_payroll

  get 'stores/:id/payroll/show' => 'payrolls#show', :as => :generate_store_payroll
  get 'employees/:id/payroll/show' => 'payrolls#emp_pay', :as => :generate_emp_payroll


  get 'shifts/show' => 'shifts#unrecorded-shifts', :as => :unrecorded_shifts  
  post 'shifts/checked' =>'shifts#checked', :as => :checked

  get 'employees/search', to: 'employees#search', as: :employee_search

  # Custom routes
  patch 'assignments/:id/terminate', to: 'assignments#terminate', as: :terminate_assignment

  # You can have the root of your site routed with 'root'
  root 'home#index'
end
