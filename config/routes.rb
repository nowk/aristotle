Rails.application.routes.draw do
  resources :prizes
  resources :sessions
  resources :users do
    resources :goals
  end
  root 'pages#home'

end
