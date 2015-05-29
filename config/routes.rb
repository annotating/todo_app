Rails.application.routes.draw do
  root                           'pages#home'
  get 'about'				 =>	 'pages#about'
  get 'users'                =>  'pages#users'
  get 'calendar'             =>  'pages#calendar'
  resources :users
  resources :tasks,          only: [:create, :destroy]
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
  
end
