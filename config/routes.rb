Rails.application.routes.draw do
	root                            		'pages#home'
	get 'about'				 			=>	'pages#about'
	get 'users'                			=>  'pages#users'
	get 'calendar'             			=>  'pages#calendar'
	get 'tasks/:year/:month/:day/' => 'tasks#show', 
	    :constraints => { :year => /\d{4}/, :month => /\d{2}/, :day => /\d{2}/ }
	resources :users
	resources :tasks,         		 		only: [:create, :update, :destroy]
	devise_for :users, :path => '', 		:path_names => {
		:sign_in => 'login', 
		:sign_out => 'logout'
	}
end
