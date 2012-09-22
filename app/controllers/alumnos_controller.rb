class AlumnosController < ApplicationController
  # GET /alumnos
  # GET /alumnos.json
  def index
    @cargotipos = CargoTipo.all
    @alumnos = Alumno.all

    #verifica que la fecha no se pase para efectuar el cargo de colegiatura para los alumnos
    fecha_actual = Time.now #Se obtiene fecha actual
    dia_de_cargo = 2 #Se indica que el dia de generación será el dia 2
    @cargo = CargoTipo.find_by_titulo("Colegiatura")
    @alumno_costos = AlumnoCosto.includes(:alumno).order("alumnos.nombre ASC").where(:cargo_tipo_id => @cargo.id)
    #if fecha_actual.day >= dia_de_cargo
    if fecha_actual.day >= dia_de_cargo
      @cargos = Cargo.where('extract(month from fecha) = ?', fecha_actual.month)
      print @cargos
      if @cargos.empty?
        @cargo = CargoTipo.find_by_titulo("Colegiatura")
        @alumno_costos = AlumnoCosto.includes(:alumno).order("alumnos.nombre ASC").where(:cargo_tipo_id => @cargo.id)
        @alumno_costos.each do |alumno_costo|
          @cargo = Cargo.new
          @cargo.fecha = Time.now
          @cargo.alumno_id = alumno_costo.alumno_id
          @cargo.cantidad = alumno_costo.cantidad
          @cargo.tipo_cargo_id = alumno_costo.cargo_tipo_id
          @cargo.save
        end
      else
        print "Ya existe cargo de este mes y no debe realizarse"
      end
    else
      print "No realizar cargo"
    end
    ############################################################################################

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alumnos }
    end
  end

  # GET /alumnos/1
  # GET /alumnos/1.json
  def show
    @alumno = Alumno.find(params[:id])
    @alumno_costos = AlumnoCosto.where(:alumno_id => params[:id])
    @cargo_tipos = CargoTipo.all
    @cargos = Cargo.where(:alumno_id => @alumno.id)
    @pagos = Pago.where(:alumno_id => @alumno.id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alumno }
    end
  end

  # GET /alumnos/new
  # GET /alumnos/new.json
  def new
    @alumno = Alumno.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alumno }
    end
  end

  # GET /alumnos/1/edit
  def edit
    @alumno = Alumno.find(params[:id])
  end

  # POST /alumnos
  # POST /alumnos.json
  def create
    if params[:nombre] == ""
      flash[:notice] = "Debe llenar el campo de 'Nombre'"
      correcto = false
    elsif params[:nombre][/[0-9]+/]
      flash[:notice] = "El campo 'Nombre' no debe contener numeros"
      correcto = false
    else
      @alumno = Alumno.new(:nombre => params[:nombre])
      if @alumno.save
        correcto = true
      else
        correcto = false
      end
    end

    if params[:colegiatura] == "1"
      if params[:costo_col] == ""
        flash[:notice] = "Debe establecer una cantidad para 'Colegiatura'"
        correcto = false
      elsif params[:costo_col][/[a-zA-Z]+/]
        flash[:notice] = "El campo de 'Colegiatura' no debe contener letras"
        correcto = false
      else
        cargo = CargoTipo.where(:titulo => 'Colegiatura').first
        alumno_costo_col = AlumnoCosto.new(:cantidad => params[:costo_col], :alumno_id => @alumno.id, :cargo_tipo_id => cargo.id)
        unless alumno_costo_col.save
          correcto = false
        end
      end
    end
    
    if params[:por_hora] == "1"
      if params[:costo_phora] == ""
        flash[:notice] = "Debe establecer una cantidad para 'Por Hora'"
        correcto = false
      elsif params[:costo_phora][/[a-zA-Z]+/]
        flash[:notice] = "El campo de 'Por Hora' no debe contener letras"
        correcto = false
      else
        cargo2 = CargoTipo.where(:titulo => "Por Hora").first
        alumno_costo_phr = AlumnoCosto.new(:cantidad => params[:costo_phora], :alumno_id => @alumno.id, :cargo_tipo_id => cargo2.id)
        unless alumno_costo_phr.save
          correcto = false
        end
      end
      
    end

    respond_to do |format|
      if correcto == true
        flash[:success] = 'El Alumno fue creado correctamente'
        format.html { redirect_to @alumno }
        format.json { render json: @alumno, status: :created, location: @alumno }
      else
        if @alumno != nil
          @alumno.destroy
        end
        format.html { render action: "new" }
        format.json { render json: @alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /alumnos/1
  # PUT /alumnos/1.json
  def update
    @alumno = Alumno.find(params[:id])
    if params[:nombre] == ""
      flash[:notice] = "Debe llenar el campo de 'Nombre'"
      correcto = false
    elsif params[:nombre][/[0-9]+/]
      flash[:notice] = "El campo 'Nombre' no debe contener numeros"
      correcto = false
    else
      @alumno.nombre = params[:nombre]
      correcto = true
    end
    
    if params[:colegiatura] != nil
      if params[:costo_col] == ""
        flash[:notice] = "Debe establecer una cantidad para 'Colegiatura'"
        correcto = false
      elsif params[:costo_col][/[a-zA-Z]+/]
        flash[:notice] = "El campo de 'Colegiatura' no debe contener letras"
        correcto = false
      else
        cargo = CargoTipo.find_by_titulo('Colegiatura')
        alumno_costo = AlumnoCosto.find(:all, :conditions => ['alumno_id = ? AND cargo_tipo_id = ?', @alumno.id, cargo.id]).first
        if alumno_costo == nil
          alumno_costo_col = AlumnoCosto.new(:cantidad => params[:costo_col], :alumno_id => @alumno.id, :cargo_tipo_id => cargo.id)
          unless alumno_costo_col.save
            correcto = false
          end
        else
          alumno_costo.cantidad = params[:costo_col]
          unless alumno_costo.save
            correcto = false
          end
        end
      end
    else
      cargo = CargoTipo.where(:titulo => 'Colegiatura').first
      alumno_costo_col = AlumnoCosto.where(:alumno_id => @alumno.id, :cargo_tipo_id => cargo.id).first
      unless alumno_costo_col == nil
        alumno_costo_col.destroy
      end
    end

    if params[:por_hora] != nil
      if params[:costo_phora] == ""
        flash[:notice] = "Debe establecer una cantidad para 'Por Hora'"
        correcto = false
      elsif params[:costo_phora][/[a-zA-Z]+/]
        flash[:notice] = "El campo de 'Por Hora' no debe contener letras"
        correcto = false
      else
        cargo2 = CargoTipo.find_by_titulo("Por Hora")
        alumno_costo = AlumnoCosto.find(:all, :conditions => ['alumno_id = ? AND cargo_tipo_id = ?', @alumno.id, cargo2.id]).first
        if alumno_costo == nil
          alumno_costo_phr_new = AlumnoCosto.new(:cantidad => params[:costo_phora], :alumno_id => @alumno.id, :cargo_tipo_id => cargo2.id)
          unless alumno_costo_phr_new.save
            correcto = false
          end
        else
          alumno_costo.cantidad = params[:costo_phora]
          unless alumno_costo.save
            correcto = false
          end
        end
      end
    else
      cargo2 = CargoTipo.where(:titulo => "Por Hora").first
      alumno_costo_phr = AlumnoCosto.where(:alumno_id => @alumno.id, :cargo_tipo_id => cargo2.id).first
      unless alumno_costo_phr == nil
        alumno_costo_phr.destroy
      end
    end

    respond_to do |format|
      if @alumno.save && (correcto == true)
        flash[:success] = 'Alumno fue actualizado Correctamente'
        format.html { redirect_to alumnos_path }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alumnos/1
  # DELETE /alumnos/1.json
  def destroy
    @alumno = Alumno.find(params[:id])
    @alumno.destroy

    respond_to do |format|
      format.html { redirect_to alumnos_url }
      format.json { head :no_content }
    end
  end


  def nuevo
    @alumno = Alumno.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alumno }
    end
  end

  def crear
    @alumno = Alumno.new(:nombre => params[:nombre])
    @alumno.save

    if params[:colegiatura] == "1"
      cargo = CargoTipo.where(:titulo => 'Colegiatura').first
      alumno_costo_col = AlumnoCosto.new(:cantidad => params[:costo_col], :alumno_id => @alumno.id, :cargo_tipo_id => cargo.id)
      alumno_costo_col.save
    end
    if params[:por_hora] == "1"
      cargo2 = CargoTipo.where(:titulo => "Por Hora").first
      alumno_costo_col = AlumnoCosto.new(:cantidad => params[:costo_phora], :alumno_id => @alumno.id, :cargo_tipo_id => cargo2.id)
      alumno_costo_col.save
    end
    
    
    redirect_to alumnos_url
  end

end
