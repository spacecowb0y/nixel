ActiveAdmin.register Presupuesto do

	# SETUP
  ALL_TYPES   	 = %w(PC Cargador Monitor Impresora Notebook Netbook Tablet Otro)
  ALL_ESTADOS 	 = %w(Bueno Regular Malo)
  ALL_ACCESORIOS = %w(Cargador Cable_de_poder Bateria Bolso Funda)
  ALL_STATUS		 = %w(Ingresado Presupuestado En_Progreso Pausado Finalizado Entregado)

  # FORM
  form do |f|
  	f.inputs do
  		f.input :status, :include_blank => false, :as => :select, :collection => ALL_STATUS
  		f.input :tipo, :include_blank => false, :as => :select, :collection => ALL_TYPES
  		f.input :marca
  		f.input :modelo
  		f.input :estado_equipo, :include_blank => false, :as => :select, :collection => ALL_ESTADOS
  		f.input :accesorios
  		f.input :falla, :input_html => { :rows => 8 }
  		f.input :backup, :input_html => { :rows => 8 }
  		f.input :valor
  		f.input :cobrado
   	end
   	f.buttons
  end

  # INDEX
  index do
  	column :id do |presupuesto|
  		link_to presupuesto.id, admin_presupuesto_path(presupuesto)
  	end
  	column :status
  	column :tipo
  	column :marca
  	column :modelo
  	column :falla
  	column :valor
  	column :cobrado do |presupuesto|
  		presupuesto.cobrado ? "Si" : "No"
  	end
  	column "Ingresado en", :created_at
  end

end
