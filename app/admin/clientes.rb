ActiveAdmin.register Cliente do
  
  # MENU
  menu :parent => "Usuarios"

  # FILTERS
  filter :nombre, :as => :select, :collection => Cliente.all.collect{|cliente| [cliente.nombre, cliente.id] }
  filter :email, :as => :select, :collection => Cliente.all.collect{|cliente| [cliente.email, cliente.id] }

  # BUTTONS
  action_item :only => [:index, :new] do
    link_to "Nuevo Presupuesto", new_admin_presupuesto_path        
  end

  # INDEX
  index do
    column :nombre
    column :email
    column :telefono_fijo
    column :telefono_movil
    column :direccion
    column "Creado en", :created_at
    default_actions
  end

  # SHOW

end
