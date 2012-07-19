ActiveAdmin.register Cliente do
  
  # MENU
  menu :parent => "Usuarios"

  # FILTERS
  filter :nombre, :as => :select, :collection => proc { Cliente.all.collect{|cliente| [cliente.nombre, cliente.id] } }
  filter :email,  :as => :select, :collection => proc { Cliente.all.collect{|cliente| [cliente.email, cliente.id] } }

  # BUTTONS
  action_item :only => [:index, :new] do
    link_to "Nuevo Presupuesto", new_admin_presupuesto_path     
  end

  action_item :only => [:show] do
    link_to "Nuevo Presupuesto"
  end

  # INDEX
  index do
    column :nombre do |cliente|
      cliente.nombre.blank? ? "N/A" : link_to(cliente.nombre, admin_cliente_path(cliente))
    end
    column :email do |cliente|
      cliente.email.blank? ? "N/A" : mail_to(cliente.email)
    end
    column :telefono_fijo do |cliente|
      cliente.telefono_fijo.blank? ? "N/A" : cliente.telefono_fijo
    end
    column :telefono_movil do |cliente|
      cliente.telefono_movil.blank? ? "N/A" : cliente.telefono_movil
    end
    column :direccion do |cliente|
      cliente.direccion.blank? ? "N/A" : cliente.direccion
    end
  end

  # SHOW
  show do
    panel "Informacion del Cliente" do
      attributes_table_for cliente do
        row :nombre
        row :email do
          mail_to cliente.email
        end
        row :telefono_fijo
        row :telefono_movil
        row :direccion
      end
    end
      table_for(cliente.presupuestos) do
        column "ID" do |presupuesto|
          link_to presupuesto.id, admin_presupuesto_path(presupuesto)
        end
        column "Cliente", :cliente do |presupuesto|
          presupuesto.cliente.nil? ? "N/A" : link_to(presupuesto.cliente.nombre, admin_cliente_path(presupuesto.cliente))
        end
        column "Estado" do |presupuesto|
          status_tag presupuesto.estado_reparacion, :error   if  %w(Ingresado).include? presupuesto.estado_reparacion
          status_tag presupuesto.estado_reparacion, :ok      if  %w(Entregado).include? presupuesto.estado_reparacion
          status_tag presupuesto.estado_reparacion, :warning if  %w(Presupuestado En_Progreso).include? presupuesto.estado_reparacion
          status_tag presupuesto.estado_reparacion           if  %w(Pausado Terminado).include? presupuesto.estado_reparacion
        end
        column "Equipo", :tipo_reparacion
        column "Falla", :falla_equipo do |presupuesto|
          presupuesto.falla_equipo.blank? ? "N/A" : truncate(presupuesto.falla_equipo, :length => 30)
        end
        column "Total", :valor_reparacion do |presupuesto|
          "$#{presupuesto.valor_reparacion}"
        end
        column "Cobrado" do |presupuesto|
          presupuesto.cobrado ? "Si" : "No"
        end
        column "Ingresado en", :created_at
      end
    
  end

  # SIDEBAR
  # sidebar "", :only => :show do
  #   attributes_table_for cliente do
  #   end
  # end
end
