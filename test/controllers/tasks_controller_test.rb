require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  def setup
	@task = tasks(:laundry)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Task.count' do
      post :create, task: { note: "Test" }
    end
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Task.count' do
      delete :destroy, id: @task
    end
    assert_redirected_to root_url
  end

  test "should redirect destroy for wrong task" do
    sign_in(users(:jill))
    task = tasks(:laundry)
    assert_no_difference 'Task.count' do
      delete :destroy, id: task
    end
    assert_redirected_to root_url
  end

end
