Rails.application.routes.draw do
  
  resources :user
  resources :topic
  resources :reaction
  resources :opinion
  get '/opinion/feed/new/:page', to: 'opinion#getnew'
  get '/opinion/feed/weird/:page', to: 'opinion#getweird'
  get '/opinion/feed/popular/:page', to: 'opinion#getpopular'
  get '/topic/feed/new/:page', to: 'topic#getnew'
  get '/topic/feed/popular/:page', to: 'topic#getpopular'
  get '/topic/query/liketopics/:input', to: 'topic#liketopics'
  get '/opinion/view/:user_id/:topic_id', to: 'opinion#userhasopinion'
  get '/user/:id/wordcloud/:resolution', to: 'user#wordcloud'
  get '/topic/:title', to: 'topic#show'
  post '/auth', to: 'auth#create'
  get '/current_user', to: 'auth#show'
  post '/signup', to: 'user#create'
  root 'welcome#index'
  
end
