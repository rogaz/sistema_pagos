class CreateAlumnoCostos < ActiveRecord::Migration
  def change
    create_table :alumno_costos do |t|
      t.decimal :cantidad
      t.integer :alumno_id
      t.integer :cargo_tipo_id

      t.timestamps
    end
  end
end
