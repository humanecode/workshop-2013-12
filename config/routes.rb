DailyStandup::Application.routes.draw do
  root "home#index"

  resources :groups, only: [:index, :show] do
    resources :days, only: [:index, :show] do
      resources :posts, only: [:index, :show, :new, :create] do
        resources :comments, only: [:new, :create]
      end
    end
  end

  # Session login/logout
  get    "login"  => "sessions#new",     as: :login
  post   "login"  => "sessions#create"
  get    "logout" => "sessions#destroy", as: :logout
  delete "logout" => "sessions#destroy"
end
