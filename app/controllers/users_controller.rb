class UsersController < ApplicationController
	before_filter :verify_login
	before_action :correct_user,   only: [:edit, :update]

	def show
	    @user = User.find(params[:id])
	end

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_url) unless current_user == @user
  	end
end
