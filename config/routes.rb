Rails.application.routes.draw do
  root 'pages#home'

  # Resources
  resources :prizes
  resources :sessions
  resources :checkins, only: [:create, :destroy]
  resources :users do
    resources :goals, except: :show
  end

  # Odds n' Ends
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get '/users/:user_id/goals/:id', to: 'goals#show', defaults: { date_string: Date.today.strftime('%m%d%Y') }, as: 'goal'
  get '/users/:user_id/goals/:id/:date_string', to: 'goals#show', as: 'goal_with_date' 

end
