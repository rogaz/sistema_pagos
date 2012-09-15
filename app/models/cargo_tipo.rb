class CargoTipo < ActiveRecord::Base
  attr_accessible :titulo

  has_many :alumno_costos, :foreign_key => "cargo_tipo_id"
  validate :titulo, :uniqueness => true
end
