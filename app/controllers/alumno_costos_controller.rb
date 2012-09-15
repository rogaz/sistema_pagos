class AlumnoCostosController < ApplicationController
  # GET /alumno_costos
  # GET /alumno_costos.json
  def index
    @cargotipos = CargoTipo.all
    if params[:id]
      @cargo = CargoTipo.find(params[:id])
      @alumno_costos = AlumnoCosto.includes(:alumno).order("alumnos.nombre ASC").where(:cargo_tipo_id => @cargo.id)
    else
      @alumno_costos = AlumnoCosto.all
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alumno_costos }
    end
  end

  # GET /alumno_costos/1
  # GET /alumno_costos/1.json
  def show
    @alumno_costo = AlumnoCosto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alumno_costo }
    end
  end

  # GET /alumno_costos/new
  # GET /alumno_costos/new.json
  def new
    @alumno_costo = AlumnoCosto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alumno_costo }
    end
  end

  # GET /alumno_costos/1/edit
  def edit
    @alumno_costo = AlumnoCosto.find(params[:id])
  end

  # POST /alumno_costos
  # POST /alumno_costos.json
  def create
    @alumno_costo = AlumnoCosto.new(params[:alumno_costo])

    respond_to do |format|
      if @alumno_costo.save
        format.html { redirect_to @alumno_costo, notice: 'Alumno costo was successfully created.' }
        format.json { render json: @alumno_costo, status: :created, location: @alumno_costo }
      else
        format.html { render action: "new" }
        format.json { render json: @alumno_costo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /alumno_costos/1
  # PUT /alumno_costos/1.json
  def update
    @alumno_costo = AlumnoCosto.find(params[:id])

    respond_to do |format|
      if @alumno_costo.update_attributes(params[:alumno_costo])
        format.html { redirect_to @alumno_costo, notice: 'Alumno costo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @alumno_costo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alumno_costos/1
  # DELETE /alumno_costos/1.json
  def destroy
    @alumno_costo = AlumnoCosto.find(params[:id])
    @alumno_costo.destroy

    respond_to do |format|
      format.html { redirect_to alumno_costos_url }
      format.json { head :no_content }
    end
  end
end
