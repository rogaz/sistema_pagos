class CargosController < ApplicationController
  # GET /cargos
  # GET /cargos.json
  def index
    @cargos = Cargo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cargos }
    end
  end

  # GET /cargos/1
  # GET /cargos/1.json
  def show
    @cargo = Cargo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cargo }
    end
  end

  # GET /cargos/new
  # GET /cargos/new.json
  def new
    @cargo = Cargo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cargo }
    end
  end

  # GET /cargos/1/edit
  def edit
    @cargo = Cargo.find(params[:id])
  end

  # POST /cargos
  # POST /cargos.json
  def create
    if params[:cargotipo] == nil
      @cargo = Cargo.new(params[:cargo])
    else
      cantidad = AlumnoCosto.find_by_cargo_tipo_id(params[:cargotipo]).cantidad
      @cargo = Cargo.new
      @cargo.tipo_cargo_id = params[:cargotipo]
      @cargo.alumno_id = params[:alumno]
      @cargo.fecha = Time.now
      @cargo.cantidad = cantidad
    end

    respond_to do |format|
      if @cargo.save
        flash[:success] = "El cargo ha sido agregado correctamente"
        format.html { redirect_to cargos_path }
        format.json { render json: @cargo, status: :created, location: @cargo }
      else
        format.html { render action: "new" }
        format.json { render json: @cargo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cargos/1
  # PUT /cargos/1.json
  def update
    @cargo = Cargo.find(params[:id])

    respond_to do |format|
      if @cargo.update_attributes(params[:cargo])
        format.html { redirect_to @cargo, notice: 'Cargo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cargo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cargos/1
  # DELETE /cargos/1.json
  def destroy
    @cargo = Cargo.find(params[:id])
    @cargo.destroy

    respond_to do |format|
      format.html { redirect_to cargos_url }
      format.json { head :no_content }
    end
  end
end
