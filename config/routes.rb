Rails.application.routes.draw do
  
  resources :user
  resources :topic
  resources :reaction
  resources :opinion
  get '/opinion/feed/new/:page', to: 'opinion#getnew'
  get '/opinion/feed/weird/:page', to: 'opinion#getweird'
  get '/opinion/feed/popular/:page', to: 'opinion#getpopular'
  get '/topic/query/liketopics/:input', to: 'topic#liketopics'
  post '/auth', to: 'auth#create'
  get '/current_user', to: 'auth#show'
  post '/signup', to: 'user#create'
  root 'welcome#index'
  
end
