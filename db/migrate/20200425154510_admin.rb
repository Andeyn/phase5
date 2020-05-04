class Admin < ActiveRecord::Migration[5.2]
  def up
    admin = Employee.new
    admin.first_name = "Gina"
    admin.last_name = "Casserole"
    admin.username = "gina"
    admin.password = "secret"
    admin.password_confirmation = "secret"
    admin.role = "admin"
    admin.save
  end
  def down
    admin = Employee.find_by_username "gina"
    Employee.delete admin
  end
end
