require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(email:"user@test.com", 
						password: "deadbeef", password_confirmation: "deadbeef")
	end

	test "email should be present" do
		@user.email = " "
		assert_not @user.valid?
	end

  	test "email addresses should be unique" do
  		duplicate_user = @user.dup
  		duplicate_user.email = @user.email.upcase
  		@user.save
  		assert_not duplicate_user.valid?
	end

	test "associated tasts should be destroyed" do
		@user.save!
		@user.tasks.create!(note: "blah")
		assert_difference 'Task.count', -1 do
		  @user.destroy
		end
	end

end
