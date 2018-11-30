require 'test_helper'

class ValidatorsControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get validators_url
    assert_response :success
  end

  test "should get new" do
    get new_validator_url
    assert_response :success
  end

  test "can see the welcome page" do 
    get "/"
    assert_select "h1","Pico y Placa"
  end

  test "The nabvar has two options Home and Verify placa" do 
    get "/"
    assert_select "li","Inicio"
    assert_select "li","Consultar Placa"
  end

  test 'validating title form placa' do
    # Visit the index page
    get new_validator_url
    assert_select 'h1', 'Validar Placa'
  end

  test "Validating fields in form" do
    # Click the New User link
    get new_validator_url
    assert_response :ok
    assert_select 'form' do
      assert_select 'input#validator_placa'
      assert_select 'input#validator_date'
      assert_select 'input#validator_time'
    end
  end

  test "validating placa" do
    placa_attributes = {
      placa: 'AEO-1230',
      date: '2018-11-30',
      time: '2:30'
    }
    post validators_validate_url, params: { validator: placa_attributes }
    assert_response :redirect
    follow_redirect!
    assert_select "div.flash", "Puede conducir"

    placa_attributes = {
      placa: 'AEO-1230',
      date: '2018-11-30',
      time: '17:30'
    }
    post validators_validate_url, params: { validator: placa_attributes }
    assert_response :redirect
    follow_redirect!
    assert_select "div.flash", "Por la hora, usted no puede conducir el vehículo"

    placa_attributes = {
      placa: 'AE123098',
      date: '2018-11-30',
      time: '17:30'
    }
    post validators_validate_url, params: { validator: placa_attributes }
    assert_template :new
    assert_select "div.flash", "Formato de placa invalido"

    placa_attributes = {
      placa: 'AEO-1238',
      date: '2018-11-30',
      time: '17:30'
    }
    post validators_validate_url, params: { validator: placa_attributes }
    assert_response :redirect
    follow_redirect!
    assert_select "div.flash", "Puede conducir" 
  end
end
