class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  	def verify_login
	    unless user_signed_in?
	      render :template => 'pages/home'
	    end
  	end
end
