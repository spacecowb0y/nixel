class CreatePresupuestos < ActiveRecord::Migration
	def change
		create_table :presupuestos do |t|
			t.string  :status, :default => 'Ingresado'
			t.string  :tipo
			t.string  :marca
			t.string  :modelo
			t.string  :estado_equipo
			t.string  :accesorios
			t.text	  :falla
			t.text	  :backup
			t.float	  :valor
			t.boolean :cobrado
			#
			# accesorios
			# cargador
			# cable de poder
			# funda
			# bolso
			# cable datos
			# detalles_backup
			# 
			#
			#
			t.timestamps
		end
	end
end
