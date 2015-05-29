class UsersController < ApplicationController
	before_filter :verify_login

	def show
	    @user = User.find(params[:id])
	end
end
