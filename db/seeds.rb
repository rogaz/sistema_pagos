# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
    #Cargo_tipo.create([{titulo: 'Colegiatura'}, {titulo: 'Por hora'}])
    #Alumno.create([{nombre: 'Juan'}, {nombre: 'Pedro'}])

CargoTipo.delete_all

ActiveRecord::Base.connection.execute 'ALTER SEQUENCE cargo_tipos_id_seq RESTART WITH 1;'

CargoTipo.create(titulo: 'Por Hora')
CargoTipo.create(titulo: 'Colegiatura')

p CargoTipo.all

puts 'cargo_tipos creados correctamente.'
