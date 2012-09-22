module AlumnosHelper
  def es_de_col?
    cargo = CargoTipo.find_by_titulo("Colegiatura")
    id = cargo.id
    alumno_costo = AlumnoCosto.find(:all, :conditions => ['alumno_id = ? AND cargo_tipo_id = ?', @alumno.id, id]).first
    if alumno_costo == nil
      return false
    else
      return true
    end
  end

  def es_de_phr?
    cargo = CargoTipo.find_by_titulo("Por Hora")
    id = cargo.id
    alumno_costo = AlumnoCosto.find(:all, :conditions => ['alumno_id = ? AND cargo_tipo_id = ?', @alumno.id, id]).first
    if alumno_costo == nil
      return false
    else
      return true
    end
  end

  def costo_col
    cargo = CargoTipo.find_by_titulo("Colegiatura")
    id = cargo.id
    alumno_costo = AlumnoCosto.find(:all, :conditions => ['alumno_id = ? AND cargo_tipo_id = ?',@alumno.id, id]).first
    costo = alumno_costo.cantidad
    return costo
  end

  def costo_phora
    cargo = CargoTipo.find_by_titulo("Por Hora")
    id = cargo.id
    alumno_costo = AlumnoCosto.find(:all, :conditions => ['alumno_id = ? AND cargo_tipo_id = ?',@alumno.id, id]).first
    costo = alumno_costo.cantidad
    return costo
  end

  def fecha_con_formato(fecha)
    unless fecha == nil
      meses = "Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Diciembre".split(" ")
      mes = meses[fecha.month-1]
      fecha = fecha.day.to_s + "/" + mes + "/" + fecha.year.to_s
      return fecha
    end
  end

end
