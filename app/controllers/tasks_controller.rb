class TasksController < ApplicationController
  before_filter :verify_login
  before_action :correct_user,   only: :destroy

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
    else
      @task_items = []
      flash[:error] = @task.errors.empty? ? "" : @task.errors.full_messages.to_sentence
    end
    redirect_to root_url
  end

  def update
    @task = Task.find(params[:id])
    if @task.present? 
      if @task.update_attributes(task_params)
      else
        @task_items = []
        flash[:error] = @task.errors.empty? ? "" : @task.errors.full_messages.to_sentence
      end
      redirect_to root_url
    end
  end

  def show
    @task_date = DateTime.new(params[:year].to_f, params[:month].to_f, params[:day].to_f)
    @tasks_from_date = Task.where({
      user_id: current_user.id,
      created_at: @task_date.beginning_of_day..@task_date.end_of_day
    })
  end

  def destroy
     @task = Task.find(params[:id])
    if @task.present?
      @task.destroy
  	end
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
