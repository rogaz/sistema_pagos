class AlumnoCosto < ActiveRecord::Base
  attr_accessible :cantidad, :alumno_id, :cargo_tipo_id
  
  belongs_to :alumno, :foreign_key => "alumno_id"
  belongs_to :cargo_tipo, :foreign_key => "cargo_tipo_id"

  validates :cantidad, :presence => true
  validates_uniqueness_of :alumno_id, :scope => :cargo_tipo_id
end
