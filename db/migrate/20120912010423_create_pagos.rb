class CreatePagos < ActiveRecord::Migration
  def change
    create_table :pagos do |t|
      t.decimal :cantidad
      t.date :fecha
      t.integer :alumno_id

      t.timestamps
    end
  end
end
