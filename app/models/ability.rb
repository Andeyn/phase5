class Ability
  include CanCan::Ability

  def initialize(employee)
    # set Employee to new employee if not logged in
    employee ||= Employee.new # i.e., a guest employee
    
    # set authorizations for different user roles
    if employee.role? :admin
      can :manage, :all
      
    elsif employee.role? :manager
      # can manage shifts and shiftjobs
      can :manage, Shift
      can :manage, ShiftJob
      
      # can see lists of stores (controller filters automatically)
      can :index, Store

      # they can read the store's data
      can :show, Store do |this_store|  
        my_store = employee.stores.map(&:id)
        my_store.include? this_store.id 
      end

      # can see lists of Assignments (controller filters automatically)
      can :index, Assignment

      # they can read the Assignment's data
      can :show, Assignment do |this_asgn|
        my_assignees = employee.current_assignment.store.assignments.current.map(&:id)
        my_assignees.include? this_asgn.id 
      end

      # can see lists of Employee info (controller filters automatically)
      can :index, Employee

      # they can read the employees's data
      can :show, Employee do |this_employee|  
        my_employees = employee.current_assignment.store.assignments.current.map {|a| a.employee_id}
        my_employees.include? this_employee.id 
      end

      can :update, Employee do |this_employee|  
        my_employees = employee.current_assignment.store.assignments.current.map {|a| a.employee_id}
        my_employees.include? this_employee.id 
      end

      can :edit, Employee do |this_employee|  
        my_employees = employee.current_assignment.store.assignments.current.map {|a| a.employee_id}
        my_employees.include? this_employee.id 
      end


    elsif employee.role? :employee
      # can see lists of Assignments (controller filters automatically)
      can :index, Assignment

      # they can read the Assignment's data
      can :show, Assignment do |this_asgn|  
        my_asgn = employee.assignments.map(&:id)
        my_asgn.include? this_asgn.id
      end

      # they can read their own
      can :show, Employee do |this_employee|  
        this_employee.id == employee.id
      end

      can :update, Employee do |this_employee|  
        this_employee.id == employee.id
      end

    end
  end

end #class end
