require 'test_helper'

class CargoTiposControllerTest < ActionController::TestCase
  setup do
    @cargo_tipo = cargo_tipos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cargo_tipos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cargo_tipo" do
    assert_difference('CargoTipo.count') do
      post :create, cargo_tipo: { titulo: @cargo_tipo.titulo }
    end

    assert_redirected_to cargo_tipo_path(assigns(:cargo_tipo))
  end

  test "should show cargo_tipo" do
    get :show, id: @cargo_tipo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cargo_tipo
    assert_response :success
  end

  test "should update cargo_tipo" do
    put :update, id: @cargo_tipo, cargo_tipo: { titulo: @cargo_tipo.titulo }
    assert_redirected_to cargo_tipo_path(assigns(:cargo_tipo))
  end

  test "should destroy cargo_tipo" do
    assert_difference('CargoTipo.count', -1) do
      delete :destroy, id: @cargo_tipo
    end

    assert_redirected_to cargo_tipos_path
  end
end
