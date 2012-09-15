# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120915231647) do

  create_table "alumno_costos", :force => true do |t|
    t.decimal  "cantidad"
    t.integer  "alumno_id"
    t.integer  "cargo_tipo_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "alumnos", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cargo_tipos", :force => true do |t|
    t.string   "titulo"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cargos", :force => true do |t|
    t.date     "fecha"
    t.integer  "alumno_id"
    t.integer  "tipo_cargo_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.decimal  "cantidad"
  end

  create_table "pagos", :force => true do |t|
    t.decimal  "cantidad"
    t.date     "fecha"
    t.integer  "alumno_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "nombre"
    t.string   "login"
    t.string   "persistence_token"
    t.string   "crypted_password"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

end
