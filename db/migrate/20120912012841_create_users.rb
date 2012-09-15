class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nombre
      t.string :login
      t.string :persistence_token
      t.string :crypted_password

      t.timestamps
    end
  end
end
