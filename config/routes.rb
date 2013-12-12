DailyStandup::Application.routes.draw do
  root "home#index"

  resources :groups, only: [:index, :show]

  # Session login/logout
  get    "login"  => "sessions#new",     as: :login
  post   "login"  => "sessions#create"
  get    "logout" => "sessions#destroy", as: :logout
  delete "logout" => "sessions#destroy"
end
