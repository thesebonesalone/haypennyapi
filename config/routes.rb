Rails.application.routes.draw do
  
  resources :user
  resources :topic
  resources :reaction
  resources :opinion
  post '/auth', to: 'auth#create'
  root 'welcome#index'
  
end
