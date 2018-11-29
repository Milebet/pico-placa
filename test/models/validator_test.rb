require 'test_helper'

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

end
