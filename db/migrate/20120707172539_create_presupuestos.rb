class CreatePresupuestos < ActiveRecord::Migration
	def change
		create_table :presupuestos do |t|
			t.integer :cliente_id
			t.string  :estado_reparacion, :default => 'Ingresado'
			t.string  :tipo
			t.string  :marca
			t.string  :modelo
			t.string  :estado_equipo
			t.string  :accesorios
			t.text	  :falla
			t.text	  :backup
			t.float	  :adelanto, :default => 0.0
			t.float	  :valor, :default => 0.0
			t.boolean :cobrado, :default => false
			t.timestamps
		end
	end
end
