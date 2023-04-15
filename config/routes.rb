Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :random_acts, only: [:index]

      resources :good_deeds, only: [:index]

      resources :users do
        resources :good_deeds, only: [:create, :destroy, :show, :update], controller: 'users/good_deeds'
      end
    end
  end

  # delete "/api/v1/users/:user_id/good_deeds/:id", to: "users/good_deeds#destroy"
end
