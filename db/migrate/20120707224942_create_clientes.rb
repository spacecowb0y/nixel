class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :nombre
      t.string :email
      t.string :telefono_fijo
      t.string :telefono_movil
      t.string :direccion
      t.timestamps
    end
  end
end
