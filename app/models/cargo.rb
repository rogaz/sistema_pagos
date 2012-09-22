class Cargo < ActiveRecord::Base
  attr_accessible :alumno_id, :fecha, :tipo_cargo_id

  belongs_to :alumno, :foreign_key => "alumno_id"
end
