class TasksController < ApplicationController
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "Task created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def destroy
     @task = Task.find(params[:id])
    if @task.present?
      @task.destroy
  	end
    flash[:success] = "Task deleted!"
    redirect_to root_url
  end

    private

    def task_params
      params.require(:task).permit(:note, :completed_at)
    end
end
