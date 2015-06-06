require 'test_helper'

class TaskActionsTest < ActionDispatch::IntegrationTest
  def setup
  	@user = users(:trevor)
  	get user_session_path
    response = post user_session_path, 'user[email]' => @user.email, 'user[password]' => 'fakebeef'
	assert_equal(302, response, "LOGIN FAILED") 
  end

  test "invalid task " do 
	assert_no_difference 'Task.count' do
		post tasks_path, task: { note: "" }
	end
  end

  test "insert new task" do
  	note = "grill squash"
	assert_difference '@user.tasks.count', 1 do
  		post tasks_path, task: { note: note, user_id: 1 }
	end	
	assert_not_nil Task.find_by(user_id: @user.id, note: note)
  end

  test "delete task" do 
    task = @user.tasks.build(note: "new task")
    task.save!
    assert_difference '@user.tasks.count', -1 do
      delete task_path(task)
  	end
  end
   
end
