Rails.application.routes.draw do
  
  resources :user
  resources :topic
  resources :reaction
  resources :opinion
  resources :comment
  get '/opinion/view/:id', to: 'opinion#viewopinion'
  get '/opinion/feed/new/:page', to: 'opinion#getnew'
  get '/opinion/feed/weird/:page', to: 'opinion#getweird'
  get '/opinion/feed/popular/:page', to: 'opinion#getpopular'
  get '/topic/feed/new/:page', to: 'topic#getnew'
  get '/topic/feed/popular/:page', to: 'topic#getpopular'
  get '/topic/query/liketopics/:input', to: 'topic#liketopics'
  get '/opinion/view/:user_id/:topic_id', to: 'opinion#userhasopinion'
  get '/user/:id/wordcloud/:resolution', to: 'user#wordcloud'
  get '/topic/:id/wordcloud/:resolution', to: 'topic#wordcloud'
  get '/user/:id/opinions/new/:page', to: 'user#useropinionsnew'
  get '/user/:id/opinions/popular/:page', to: 'user#useropinionspopular'
  get '/user/:id/opinions/weird/:page', to: 'user#useropinionsweird'
  get '/topic/:id/opinions/new/:page', to: 'topic#topicnewopinions'
  get '/topic/:id/opinions/popular/:page', to: 'topic#topicpopularopinions'
  get '/topic/:id/opinions/weird/:page', to: 'topic#topicweirdopinions'
  get '/comment/usercomments/:id', to: 'comment#usercomments'
  get '/comment/opinioncomments/:id', to: 'comment#opinioncomments'
  get '/comment/useropinioncomments/:id/:user_id', to: 'comment#useropinioncomments'
  get '/topic/:title', to: 'topic#show'
  post '/auth', to: 'auth#create'
  get '/current_user', to: 'auth#show'
  post '/signup', to: 'user#create'
  root 'welcome#index'
  
end
