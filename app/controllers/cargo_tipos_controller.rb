class CargoTiposController < ApplicationController
  # GET /cargo_tipos
  # GET /cargo_tipos.json
  def index
    @cargo_tipos = CargoTipo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cargo_tipos }
    end
  end

  # GET /cargo_tipos/1
  # GET /cargo_tipos/1.json
  def show
    @cargo_tipo = CargoTipo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cargo_tipo }
    end
  end

  # GET /cargo_tipos/new
  # GET /cargo_tipos/new.json
  def new
    @cargo_tipo = CargoTipo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cargo_tipo }
    end
  end

  # GET /cargo_tipos/1/edit
  def edit
    @cargo_tipo = CargoTipo.find(params[:id])
  end

  # POST /cargo_tipos
  # POST /cargo_tipos.json
  def create
    @cargo_tipo = CargoTipo.new(params[:cargo_tipo])

    respond_to do |format|
      if @cargo_tipo.save
        format.html { redirect_to @cargo_tipo, notice: 'Cargo tipo was successfully created.' }
        format.json { render json: @cargo_tipo, status: :created, location: @cargo_tipo }
      else
        format.html { render action: "new" }
        format.json { render json: @cargo_tipo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cargo_tipos/1
  # PUT /cargo_tipos/1.json
  def update
    @cargo_tipo = CargoTipo.find(params[:id])

    respond_to do |format|
      if @cargo_tipo.update_attributes(params[:cargo_tipo])
        format.html { redirect_to @cargo_tipo, notice: 'Cargo tipo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cargo_tipo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cargo_tipos/1
  # DELETE /cargo_tipos/1.json
  def destroy
    @cargo_tipo = CargoTipo.find(params[:id])
    @cargo_tipo.destroy

    respond_to do |format|
      format.html { redirect_to cargo_tipos_url }
      format.json { head :no_content }
    end
  end
end
