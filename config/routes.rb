Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :random_acts, only: [:index]

      resources :good_deeds, only: [:index]

      resources :users do
        resources :good_deeds, only: %i[create destroy show update], controller: 'users/good_deeds'
      end
    end
  end
end
