Rails.application.routes.draw do
  devise_for :users, controllers:{
    registrations: 'users/registrations'
  }
  
  resources :stories

  get '@:username/story_id' , to: 'index#show' , as: 'story_index'
  get '@:username' , to: 'index#user' , as: 'user_index'

  root 'index#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
