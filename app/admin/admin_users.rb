ActiveAdmin.register AdminUser do

  # MENU
  menu :label => "Administradores", :parent => "Usuarios"

  # FILTERS
  filter :email, :as => :select, :collection => AdminUser.all.collect{|cliente| [cliente.email, cliente.id] }

  # INDEX
  index do
    column :email
    column "Ultimo ingreso al sistema", :last_sign_in_at
    default_actions
  end

  # FORM
  form do |f|
    f.inputs "Informacion del usuario" do
      f.input :email
    end
    f.buttons
  end

end
