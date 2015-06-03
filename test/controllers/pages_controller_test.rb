require 'test_helper'

class PagesControllerTest < ActionController::TestCase

  def setup
  	@user = users(:trevor)
  end

  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "users should redirect to root if not logged in" do
    get :users
    assert_redirected_to root_url
  end

  test "should get users" do
  	sign_in :user, @user 
    get :users
    assert_response :success
  end

  test "calendar should redirect to root if not logged in" do
    get :calendar
    assert_redirected_to root_url
  end

  test "should get calendar" do
  	sign_in :user, @user 
    get :calendar
    assert_response :success
  end

end
