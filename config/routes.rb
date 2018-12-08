Rails.application.routes.draw do
  resources :recruitments
  resources :comments
  resources :chat_comments
  resources :accounts
  resources :entry_chats
  resources :chats
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/mains', to: 'mains#index'
  get '/mains/log', to: 'mains#login'
  get '/mains/home', to: 'mains#home'
  get '/logins', to: 'login#index'
  get '/acc_views', to: 'acc_view#index'
  get '/cushions/:id', to: 'jumps#index'
  get '/member', to: 'member#index'
end
