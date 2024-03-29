ActiveAdmin.register AdminUser, :as => 'Empleado' do

  # MENU
  menu :label => "Empleados", :parent => "Usuarios"

  # FILTERS
  filter :email, :as => :select, :collection => proc { AdminUser.all.collect{|cliente| [cliente.email, cliente.email] } }

  # INDEX
  index :title => :page_title do
    column :name
    column :email
    column "Ultimo ingreso al sistema", :last_sign_in_at
    default_actions
  end

  # FORM
  form do |f|
    f.inputs "Informacion del usuario" do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end

end
