class Pago < ActiveRecord::Base
  attr_accessible :alumno_id, :cantidad, :fecha
end
