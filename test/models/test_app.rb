require "test_helper"

class AccountTest < ActiveSupport::TestCase

	test "my model Validator can store data" do
		res = Validator.class
		assert_equal "Class", res.to_s
	end
end