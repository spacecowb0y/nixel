class Presupuesto < ActiveRecord::Base

  # ASOCICIACION
  belongs_to :cliente
  
  serialize :accesorios_equipo
  before_save :remove_empty_items, :if => :accesorios_equipo_changed?

  def remove_empty_items
    self.accesorios_equipo.reject!(&:empty?)
  end

  def comprobantes_location
    "#{Rails.root}/tmp"
  end

end
