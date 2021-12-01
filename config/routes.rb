Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "movies#index"

  resources :movies, only: %i[index create] do
    collection do
      get "share"
    end
  end

  resources :sessions, only: :create do
    collection do
      delete "logout"
    end
  end
end
