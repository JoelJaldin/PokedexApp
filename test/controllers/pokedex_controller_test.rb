require 'test_helper'

class PokedexControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
  end

  test "should get show" do
    get show_path(8)
    assert_response :success
  end

  test "visiting the home" do
    get root_path
    assert_select "button", text: "Bienvenido a la Pokedex"
  end

  test "visiting the show" do
    get show_path(1)
    assert_select "h1", text: "Bulbasaur"
  end


end
