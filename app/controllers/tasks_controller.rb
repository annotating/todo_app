class TasksController < ApplicationController
  before_filter :verify_login
  before_action :correct_user,   only: :destroy

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "Task created!"
      redirect_to root_url
    else
      @task_items = []
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

    def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
      redirect_to root_url if @task.nil?
    end
end
