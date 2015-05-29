class UsersController < ApplicationController
	before_filter :verify_login, :except => [:about]
	
	def show
	    @user = User.find(params[:id])
	end
end
