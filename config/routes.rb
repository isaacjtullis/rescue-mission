
Rails.application.routes.draw do
  resources :questions do
  #, only: [:index, :show]
    resources :answers, only: [:index, :new, :create]
  end

  resources :answers do
    resources :favorites, only: [:create]
  end

  resources :users

  get "/auth/:provider/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout
  get "/auth/github" => "users#new"

  #get '/auth/github/callback', to:  name_of_controller#method_name (all in a string)
    #create a session controller
    #method github
    #session controllers -
  #end
  #, only: [:new, :create]
  #end

  #resources :questions, only: [:index, :create, :new]
  #resources :answers, only: [:show]

  root 'questions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


=begin
1. rescue mission
2. NameSpacing With TDD
=end
