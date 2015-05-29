class PagesController < ApplicationController

  before_filter :verify_login, :except => [:about]

  def home
  	if user_signed_in?
  		@task  = current_user.tasks.build
  		@task_items = current_user.tasks.where("created_at >= ?", Time.zone.now.beginning_of_day)
	end
  end

  def about
  end

  def users
  	@users = User.all
  end

  def calendar
	@task_items = current_user.tasks
  end

end
