require 'test_helper'

class AlumnoCostosControllerTest < ActionController::TestCase
  setup do
    @alumno_costo = alumno_costos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alumno_costos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alumno_costo" do
    assert_difference('AlumnoCosto.count') do
      post :create, alumno_costo: { cantidad: @alumno_costo.cantidad, alumno_id: @alumno_costo.alumno_id, cargo_tipo_id: @alumno_costo.cargo_tipo_id }
    end

    assert_redirected_to alumno_costo_path(assigns(:alumno_costo))
  end

  test "should show alumno_costo" do
    get :show, id: @alumno_costo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alumno_costo
    assert_response :success
  end

  test "should update alumno_costo" do
    put :update, id: @alumno_costo, alumno_costo: { cantidad: @alumno_costo.cantidad, alumno_id: @alumno_costo.alumno_id, cargo_tipo_id: @alumno_costo.cargo_tipo_id }
    assert_redirected_to alumno_costo_path(assigns(:alumno_costo))
  end

  test "should destroy alumno_costo" do
    assert_difference('AlumnoCosto.count', -1) do
      delete :destroy, id: @alumno_costo
    end

    assert_redirected_to alumno_costos_path
  end
end
