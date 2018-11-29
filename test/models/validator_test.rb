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
  	assert res.save
  end

end
