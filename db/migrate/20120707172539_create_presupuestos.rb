class CreatePresupuestos < ActiveRecord::Migration
	def change
		create_table :presupuestos do |t|
			t.integer :cliente_id
			t.string  :estado_reparacion, :default => 'Ingresado'
			t.string  :tipo_reparacion
			t.string  :marca_equipo
			t.string  :modelo_equipo
			t.string  :estado_equipo, :defualt => "Bueno"
			t.string  :accesorios_equipo
			t.text	  :falla_equipo
			t.text	  :backup_equipo
			t.float	  :adelanto_reparacion, :default => 0.0
			t.float	  :valor_reparacion, :default => 0.0
			t.boolean :cobrado, :default => false
			t.timestamps
		end
	end
end
