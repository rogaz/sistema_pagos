class AlumnosController < ApplicationController
  # GET /alumnos
  # GET /alumnos.json
  def index
    @cargotipos = CargoTipo.all
    @alumnos = Alumno.all
        
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
    @alumno = Alumno.new(:nombre => params[:nombre])
    if @alumno.save
      correcto = true
    else 
      correcto = false
    end
    

    if params[:colegiatura] == "1"
      cargo = CargoTipo.where(:titulo => 'Colegiatura').first
      alumno_costo_col = AlumnoCosto.new(:cantidad => params[:costo_col], :alumno_id => @alumno.id, :cargo_tipo_id => cargo.id)
      unless alumno_costo_col.save
        correcto = false
      end
    end
    if params[:por_hora] == "1"
      cargo2 = CargoTipo.where(:titulo => "Por Hora").first
      alumno_costo_phr = AlumnoCosto.new(:cantidad => params[:costo_phora], :alumno_id => @alumno.id, :cargo_tipo_id => cargo2.id)
      unless alumno_costo_phr.save
        correcto = false
      end
    end

    respond_to do |format|
      if correcto == true
        format.html { redirect_to @alumno, notice: 'Alumno was successfully created.' }
        format.json { render json: @alumno, status: :created, location: @alumno }
      else
        @alumno.destroy
        alumno_costo_col.destroy
        alumno_costo_phr.destroy
        format.html { render action: "new" }
        format.json { render json: @alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /alumnos/1
  # PUT /alumnos/1.json
  def update
    @alumno = Alumno.find(params[:id])
    @alumno.nombre = params[:nombre]

    
    if params[:colegiatura] != nil
      cargo = CargoTipo.find_by_titulo('Colegiatura')
      alumno_costo = AlumnoCosto.find(:all, :conditions => ['alumno_id = ? AND cargo_tipo_id = ?', @alumno.id, cargo.id]).first
      if alumno_costo == nil
        alumno_costo_col = AlumnoCosto.new(:cantidad => params[:costo_col], :alumno_id => @alumno.id, :cargo_tipo_id => cargo.id)
        alumno_costo_col.save
      else
        alumno_costo.cantidad = params[:costo_col]
        alumno_costo.save
      end
    else
      cargo = CargoTipo.where(:titulo => 'Colegiatura').first
      alumno_costo_col = AlumnoCosto.where(:alumno_id => @alumno.id, :cargo_tipo_id => cargo.id).first
      unless alumno_costo_col == nil
        alumno_costo_col.destroy
      end
    end

    if params[:por_hora] != nil
      cargo2 = CargoTipo.find_by_titulo("Por Hora")
      alumno_costo = AlumnoCosto.find(:all, :conditions => ['alumno_id = ? AND cargo_tipo_id = ?', @alumno.id, cargo2.id]).first
      if alumno_costo == nil
        alumno_costo_phr_new = AlumnoCosto.new(:cantidad => params[:costo_phora], :alumno_id => @alumno.id, :cargo_tipo_id => cargo2.id)
        alumno_costo_phr_new.save
      else
        alumno_costo.cantidad = params[:costo_phora]
        alumno_costo.save
      end
    else
      cargo2 = CargoTipo.where(:titulo => "Por Hora").first
      alumno_costo_phr = AlumnoCosto.where(:alumno_id => @alumno.id, :cargo_tipo_id => cargo2.id).first
      unless alumno_costo_phr == nil
        alumno_costo_phr.destroy
      end
    end

    respond_to do |format|
      if @alumno.save
        format.html { redirect_to alumnos_path, notice: 'Alumno was successfully updated.' }
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
