def generate_combrobante(presupuesto)
  # Generate invoice
  Prawn::Document.generate @presupuesto.comprobantes_location do |pdf|
    # Title
    pdf.text "Presupuesto ##{presupuesto.id}", :size => 25

    # Client info
    pdf.text presupuesto.cliente.nombre
    pdf.text presupuesto.cliente.direccion
    pdf.text presupuesto.cliente.telefono_fijo

    pdf.move_down 20

    pdf.text presupuesto.falla_equipo, :size => 8

    #pdf.draw_text "#{t('.created_at')}: #{l(invoice.created_at, :format => :short)}", :at => [pdf.bounds.width / 2, pdf.bounds.height - 30]

    # Our company info
    # pdf.float do
    #   pdf.bounding_box [0, pdf.bounds.top - 5], :width => pdf.bounds.width do
    #     pdf.text invoice.client.company.name, :size => 20, :align => :right
    #   end
    # end

    # pdf.move_down 20

    # # Items
    # header = ['Qty.', 'Description', 'Amount', 'Total']
    # items = invoice.items.collect do |item|
    #   [item.quantity.to_s, item.description, number_to_currency(item.amount), number_to_currency(item.total)]
    # end
    
    # items = items + [["", "", "Discount:", "#{number_with_delimiter(invoice.discount)}%"]] \
    #               + [["", "", "Sub-total:", "#{number_to_currency(invoice.subtotal)}"]] \
    #               + [["", "", "Taxes:", "#{number_to_currency(invoice.taxes)} (#{number_with_delimiter(invoice.tax)}%)"]] \
    #               + [["", "", "Total:", "#{number_to_currency(invoice.total)}"]]

    # pdf.table [header] + items, :header => true, :width => pdf.bounds.width do
    #   row(-4..-1).borders = []
    #   row(-4..-1).column(2).align = :right
    #   row(0).style :font_style => :bold
    #   row(-1).style :font_style => :bold
    # end
    
    #                  # :border_style => :grid, 
    #                  # :headers => header, 
    #                  # :width => pdf.bounds.width, 
    #                  # :row_colors => %w{cccccc eeeeee},
    #                  # :align => { 0 => :right, 1 => :left, 2 => :right, 3 => :right, 4 => :right }


    # # Terms
    # if invoice.terms != ''
    #   pdf.move_down 20
    #   pdf.text 'Terms', :size => 18
    #   pdf.text invoice.terms
    # end

    # # Notes
    # if invoice.notes != ''
    #   pdf.move_down 20
    #   pdf.text 'Notes', :size => 18
    #   pdf.text invoice.notes
    # end

    # Footer
    pdf.draw_text "Generated at #{l(Time.now, :format => :long)}", :at => [0, 0]
  end
end
ActiveAdmin.register Presupuesto do

	# CONFIG
  ALL_TYPES   	 = %w(PC_de_Escritorio All_in_One Notebook Netbook Cargador Monitor Impresora Telefono Tablet Otro)
  ALL_ESTADOS 	 = %w(Bueno Regular Malo)
  ALL_ACCESORIOS = %w(Cargador Cable_de_poder Bateria Bolso Funda)
  ALL_STATUS		 = %w(Ingresado Presupuestado En_Progreso Pausado Terminado Entregado Tercerizado)

  # SCOPES 
  scope :all, :default => true
  scope :ingresados do |presupuestos|
    presupuestos.where('estado_reparacion = ?', 'Ingresado')
  end
  scope :presupuestados do |presupuestos|
    presupuestos.where('estado_reparacion = ?', 'Presupuestado')
  end
  scope :en_progreso do |presupuestos|
    presupuestos.where('estado_reparacion = ?', 'En_Progreso')
  end
  scope :pausados do |presupuestos|
    presupuestos.where('estado_reparacion = ?', 'Pausado')
  end
  scope :finalizados do |presupuestos|
    presupuestos.where('estado_reparacion = ?', 'Finalizado')
  end
  scope :entregados do |presupuestos|
    presupuestos.where('estado_reparacion = ?', 'Entregado')
  end

  # FILTERS
  filter :cliente,          :as => :select, :collection => proc { Cliente.all.collect{|cliente| [cliente.nombre, cliente.id] }}, :class => "chzn-select" 
  filter :tipo_reparacion,  :as => :select, :collection => ALL_TYPES.collect{|tipo| tipo.humanize }, :label => "Tipo de reparacion"
  filter :created_at,       :label => "Ingresado en"

  # SIDEBARS
  sidebar "Detalles del Presupuesto", :only => :show do
    attributes_table_for presupuesto do
      row :cliente do
        presupuesto.cliente.blank? ? "N/A" : link_to(presupuesto.cliente.try(:nombre), admin_cliente_path(presupuesto.cliente))
      end
      row :adelanto_reparacion
      row :valor_reparacion
      row :cobrado do
        presupuesto.cobrado ? "Si" : (presupuesto.adelanto_reparacion <= 1 ? "No" : "Debe $#{(presupuesto.valor_reparacion-presupuesto.adelanto_reparacion).abs}")
      end
    end
  end

  # BUTTONS
  action_item :only => [:index, :new] do
    link_to "Nuevo Cliente", new_admin_cliente_path        
  end

  action_item :only => [:show] do
    link_to "Nuevo Presupuesto", new_admin_presupuesto_path(:presupuesto => { :cliente_id => params[:id] })
  end

  # FORM
  form do |f|
    f.inputs "Datos Basicos" do
      f.input :cliente,           :include_blank => false, :as => :select, :collection => Cliente.all.collect{|cliente| [cliente.nombre, cliente.id] }, :input_html => { "data-placeholder" => "Seleccione un cliente" }
      f.input :estado_reparacion, :include_blank => false, :as => :select, :collection => ALL_STATUS.collect{|estado_reparacion| [estado_reparacion.humanize, estado_reparacion] }, :label => "Estado del presupuesto"
      f.input :tipo_reparacion,   :include_blank => false, :as => :select, :collection => ALL_TYPES.collect{|tipo| tipo.humanize }, :label => "Tipo de reparacion"
    end
  	f.inputs "Datos del Equipo" do
  		f.input :marca_equipo,  :label => "Marca"
  		f.input :modelo_equipo, :label => "Modelo"
  		f.input :estado_equipo, :label => "Estado", :include_blank => false, :as => :radio, :collection => ALL_ESTADOS.collect{|estado_equipo| estado_equipo.humanize }
  		f.input :falla_equipo,  :label => "Falla", :input_html => { :rows => 8 }
   	end

    f.inputs "Datos Opcionales" do
      f.input :accesorios_equipo, :label => "Accesorios del equipo", :as => :check_boxes, :collection => ALL_ACCESORIOS.collect{|accesorio| accesorio.humanize }
      f.input :backup_equipo,     :label => "Backup", :input_html => { :rows => 8 }, :hint => "En caso de requerir backup, especificar los directorios que deben ser resguardos."
    end

    f.inputs "Datos del Pago" do
      f.input :adelanto_reparacion, :label => "Adelanto $"
      f.input :valor_reparacion,    :label => "Valor final de la reparacion $"
      f.input :cobrado
    end
   	f.buttons
  end

  # INDEX
  index do
  	column "ID", :sortable => :id do |presupuesto|
  		link_to presupuesto.id, admin_presupuesto_path(presupuesto)
  	end
    column "Cliente", :cliente do |presupuesto|
      presupuesto.cliente.blank? ? "N/A" : link_to(presupuesto.cliente.nombre, admin_cliente_path(presupuesto.cliente))
    end
  	column "Estado", :sortable => :estado_reparacion do |presupuesto|
      status_tag presupuesto.estado_reparacion, :error   if %w(Ingresado).include? presupuesto.estado_reparacion
      status_tag presupuesto.estado_reparacion, :ok      if %w(Entregado).include? presupuesto.estado_reparacion
      status_tag presupuesto.estado_reparacion, :warning if %w(Presupuestado En_Progreso Tercerizado).include? presupuesto.estado_reparacion
      status_tag presupuesto.estado_reparacion           if %w(Pausado Terminado).include? presupuesto.estado_reparacion
    end
  	column "Equipo", :tipo_reparacion
    column "Falla", :falla_equipo do |presupuesto|
      truncate(presupuesto.falla_equipo, :length => 30)
    end
  	column "Total", :valor_reparacion do |presupuesto|
      "$#{presupuesto.valor_reparacion}"
    end
  	column "Cobrado", :sortable => :cobrado do |presupuesto|
      presupuesto.cobrado ? "Si" : "No"
  	end
  	column "Ingresado en", :created_at
    default_actions
  end

  # SHOW
  show do 
    panel "Detalles de la Reparacion" do
      attributes_table_for presupuesto do 
        row :tipo_reparacion
        row :marca_equipo
        row :modelo_equipo
        row :estado_equipo
        row :accesorios_equipo do |presupuesto|
          presupuesto.accesorios_equipo.collect { |accesorio| accesorio }.join(", ")
        end
        row :falla_equipo
      end
    end
    active_admin_comments
  end

  # CUSTOM
  action_item :only => :show do
    link_to "Imprimir Comprobante", imprimir_admin_presupuesto_path(resource)
  end
  
  member_action :imprimir do
    @presupuesto = Presupuesto.find(params[:id])
    generate_combrobante(@presupuesto)
    send_file(@presupuesto.comprobantes_location)
  end

end
