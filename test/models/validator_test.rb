require 'test_helper'
require 'date'
class ValidatorTest < ActiveSupport::TestCase
  
  test "placa must be required" do 
  	res = Validator.new()
  	assert_not res.valid?
  end

  test "date must be required" do 
  	res = Validator.new()
  	res.placa = "AAB-0123"
  	assert_not res.valid?
  end

  test "if attribute date is not a date return false" do 
  	res = Validator.new()
  	res.placa = "AAB-0123"
  	assert_raise(ArgumentError) do
  		res.date = "My date"
  		assert_not DateTime.parse(res.date)
  	end
  	res.date = "10/06/2018"
  	assert DateTime.parse(res.date)
  end

  test "time must be required" do 
  	res = Validator.new()
  	res.placa = "AAB-0123"
  	res.date = "10/06/2018"
  	assert_not res.valid?
  end

  test "validate_placa should return true or false depending of the given placa" do 
  	res = Validator.new()
  	res.placa = "AUE-1234"
  	assert res.is_a_valid_placa?
  	res.placa = "123-1234"
  	assert_not res.is_a_valid_placa?
  	res.placa = "123-123E"
  	assert_not res.is_a_valid_placa?
  end

  test "return false if a digit is not authorized to be on the road in that day" do 
    validator = Validator.new()
    validator.date = "2018-11-29" #Jueves
    last_digit = 0 #no está authorizado los dias viernes
    assert_not validator.is_an_invalid_day?(last_digit)
    validator.date = "2018-11-30" #Viernes
    assert validator.is_an_invalid_day?(last_digit)
  end

  test "return true if an hour is between the range of invalid hours to be on the road" do 
    validator = Validator.new()
    validator.time = "8:30"
    assert validator.is_an_invalid_hour?
    validator.time = "22:30"
    assert_not validator.is_an_invalid_hour?
  end

  test "this method should return the last digit of a placa" do 
    validator = Validator.new()
    validator.placa = "AEO-2341"
    last_digit = 1
    assert_equal = last_digit, validator.get_last_digit
  end
end
