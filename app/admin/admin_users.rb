ActiveAdmin.register AdminUser do

  # MENU
  menu :label => "Administradores", :parent => "Usuarios"

  # FILTERS
  filter :email

  # INDEX
  index do
    column :email
    column "Ultimo ingreso al sistema", :last_sign_in_at
  end

end
