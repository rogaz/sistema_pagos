class CreateCargoTipos < ActiveRecord::Migration
  def change
    create_table :cargo_tipos do |t|
      t.string :titulo

      t.timestamps
    end
  end
end
