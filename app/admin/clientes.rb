ActiveAdmin.register Cliente do
  
  # MENU
  menu :parent => "Usuarios"

  # FILTERS
  filter :nombre
  filter :email

  # INDEX
  index do
    column :nombre
    column :email
    column :telefono_fijo
    column :telefono_movil
    column :direccion
    column "Creado en", :created_at
  end

  # SHOW

end
