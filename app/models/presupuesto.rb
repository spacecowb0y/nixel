class Presupuesto < ActiveRecord::Base

  # ASOCICIACION
  belongs_to :cliente

  def esta_activo?
    return true if %w(Presupuestado En_Progreso).include? self.estado_reparacion
  end

end
