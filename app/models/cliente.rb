class Cliente < ActiveRecord::Base

  # ASOCIACION
  has_many :presupuestos

end
