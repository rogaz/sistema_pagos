class AddCantidadToCargos < ActiveRecord::Migration
  def change
    add_column :cargos, :cantidad, :decimal
  end
end
