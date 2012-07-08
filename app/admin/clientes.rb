ActiveAdmin.register Cliente do
  
  # MENU
  menu :parent => "Usuarios"

  # INDEX
  index do
    column :nombre
    column :email
    column :telefono_fijo
    column :telefono_movil
    column "Creado en", :created_at
  end

  # SHOW

end
