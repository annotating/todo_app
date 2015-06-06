require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
  	@user1 = users(:trevor)
  	@user2 = users(:jill)
  end

  test "should redirect edit for wrong user" do
    sign_in(@user1)
    get :edit, id: @user2
    assert_redirected_to root_url
  end

end
