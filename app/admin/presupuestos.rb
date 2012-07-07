ActiveAdmin.register Presupuesto do

	# CONFIG
  ALL_TYPES   	 = %w(Computadora_de_escritorio Notebook Netbook Cargador Monitor Impresora Telefono Tablet Otro)
  ALL_ESTADOS 	 = %w(Bueno Regular Malo)
  ALL_ACCESORIOS = %w(Cargador Cable_de_poder Bateria Bolso Funda)
  ALL_STATUS		 = %w(Ingresado Presupuestado En_Progreso Pausado Finalizado Entregado)

  # FORM
  form do |f|
    f.inputs "Datos del Cliente" do
      f.input :cliente, :as => :select, :collection => Cliente.all.collect{|cliente| [cliente.nombre, cliente.id] }
    end
  	f.inputs "Detalles del Presupuesto" do
  		f.input :estado_reparacion, :include_blank => false, :as => :select, :collection => ALL_STATUS.collect{|estado_reparacion| estado_reparacion.humanize }, :label => "Estado de la reparacion"
  		f.input :tipo, :include_blank => false, :as => :select, :collection => ALL_TYPES.collect{|tipo| tipo.humanize }, :label => "Tipo de equipo"
  		f.input :marca
  		f.input :modelo
  		f.input :estado_equipo, :include_blank => false, :as => :select, :collection => ALL_ESTADOS.collect{|estado_equipo| estado_equipo.humanize }, :label => "Estado del equipo"
  		f.input :accesorios
  		f.input :falla, :input_html => { :rows => 8 }
  		f.input :backup, :input_html => { :rows => 8 }
   	end
    f.inputs "Detalles del Pago" do
      f.input :adelanto
      f.input :valor
      f.input :cobrado
    end
   	f.buttons
  end

  # FILTERS

  filter :estado_reparacion, :as => :select, :collection => ALL_STATUS, :label => "Estado de la reparacion"
  filter :tipo, :as => :select, :collection => ALL_TYPES, :label => "Tipo de Equipo"
  filter :cobrado, :as => :select

  # INDEX
  index do
  	column "ID", :id do |presupuesto|
  		link_to presupuesto.id, admin_presupuesto_path(presupuesto)
  	end
  	column "Estado", :estado_reparacion
  	column "Tipo de Equipo", :tipo
  	column :marca
  	column :modelo
  	column :falla
  	column :valor
  	column :cobrado do |presupuesto|
  		presupuesto.cobrado ? "Si" : "No"
  	end
  	column "Ingresado en", :created_at
  end

  # SHOW

end
