class Alumno < ActiveRecord::Base
  attr_accessible :nombre
  
  has_many :alumno_costos, :foreign_key => "alumno_id", :dependent => :destroy
  validate :nombre, :presence => true, :length => {:within => 5..60}
  default_scope :order => 'alumnos.nombre ASC'
end
