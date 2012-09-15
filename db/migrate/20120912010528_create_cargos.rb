class CreateCargos < ActiveRecord::Migration
  def change
    create_table :cargos do |t|
      t.date :fecha
      t.integer :alumno_id
      t.integer :tipo_cargo_id

      t.timestamps
    end
  end
end
