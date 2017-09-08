Rails.application.routes.draw do
  devise_for :users, :path_prefix => 'my'
  resources :users
  get 'welcome/index'
  root "projects#index"
  get"welcome/pStack", to: 'welcome#pStack'
  resources :tasks
  resources :timesheets do
  collection do
   get 'filter'
 end
 end
 get "/pipeline", to: 'timesheets#pipeline'
  resources :projects do
        member do
             get 'manage'
             post '/join' , to: 'projections#create'
      end
  end
  resources :projections
namespace :api, defaults: {format: 'json'} do
      #Devise Token Auth Implementation
      mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
      # Projects API
      get '/projects', to: 'projects#index'
      post '/projects', to: 'projects#create'
      put '/projects/:id', to: 'projects#update'
      # Tasks API
      get '/tasks', to: 'tasks#index'
      delete '/tasks/:id', to: 'tasks#destroy'
      # Timesheets API
      get '/timesheets', to: 'timesheets#index'
      post '/timesheets', to: 'timesheets#create'
      delete 'timesheets/:id', to: 'timesheets#destroy'
      #Projection API
      get '/projections', to: 'projections#index'
      post '/projections',to: 'projections#create'
      #User API
      get '/users', to: 'users#index'
      put '/users/:id', to: 'users#update'
      delete '/users/:id', to: 'users#destroy'
      #Dashboard Data
      get '/data', to:'data#index'
      get '/data/:id', to:'data#show'
#  resources :projects, :tasks, :timesheets
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
