ActiveAdmin.register Presupuesto do

	# CONFIG
  ALL_TYPES   	 = %w(Computadora_de_escritorio Notebook Netbook Cargador Monitor Impresora Telefono Tablet Otro)
  ALL_ESTADOS 	 = %w(Bueno Regular Malo)
  ALL_ACCESORIOS = %w(Cargador Cable_de_poder Bateria Bolso Funda)
  ALL_STATUS		 = %w(Ingresado Presupuestado En_Progreso Pausado Finalizado Entregado)

  # FILTERS
  filter :cliente, :as => :select, :collection => Cliente.all.collect{|cliente| [cliente.nombre, cliente.id] }
  filter :estado_reparacion, :as => :select, :collection => ALL_STATUS.collect{|estado_reparacion| estado_reparacion.humanize }, :label => "Estado de la reparacion"
  filter :tipo_reparacion, :as => :select, :collection => ALL_TYPES.collect{|tipo| tipo.humanize }, :label => "Tipo de reparacion", :label => "Tipo de reparacion"
  filter :cobrado, :as => :select

  # FORM
  form do |f|
    f.inputs "Datos Basicos" do
      f.input :cliente, :as => :select, :collection => Cliente.all.collect{|cliente| [cliente.nombre, cliente.id] }
      f.input :estado_reparacion, :include_blank => false, :as => :select, :collection => ALL_STATUS.collect{|estado_reparacion| estado_reparacion.humanize }, :label => "Estado del presupuesto"
      f.input :tipo_reparacion, :include_blank => false, :as => :select, :collection => ALL_TYPES.collect{|tipo| tipo.humanize }, :label => "Tipo de reparacion"
    end
  	f.inputs "Datos del Equipo" do
  		f.input :marca_equipo, :label => "Marca"
  		f.input :modelo_equipo, :label => "Modelo"
  		f.input :estado_equipo, :include_blank => false, :as => :select, :collection => ALL_ESTADOS.collect{|estado_equipo| estado_equipo.humanize }, :label => "Estado"
  		f.input :falla_equipo, :input_html => { :rows => 8 }, :label => "Falla"
   	end

    f.inputs "Datos Opcionales" do
      f.input :accesorios_equipo, :label => "Accesorios del equipo"
      f.input :backup_equipo, :input_html => { :rows => 8 }, :label => "Backup", :hint => "En caso de requerir backup, especificar los directorios que deben ser resguardos."
    end

    f.inputs "Datos del Pago" do
      f.input :adelanto_reparacion, :label => "Adelanto $"
      f.input :valor_reparacion, :label => "Valor final de la reparacion $"
      f.input :cobrado
    end
   	f.buttons
  end

  # INDEX
  index do
  	column "ID", :id do |presupuesto|
  		link_to presupuesto.id, admin_presupuesto_path(presupuesto)
  	end
  	column "Estado", :estado_reparacion
  	column "Tipo de Equipo", :tipo_reparacion
  	column "Marca", :marca_equipo
  	column "Modelo", :modelo_equipo
  	column "Falla", :falla_equipo
  	column "Total", :valor_reparacion
  	column :cobrado do |presupuesto|
  		presupuesto.cobrado ? "Si" : "No"
  	end
  	column "Ingresado en", :created_at
  end

  # SHOW

end
