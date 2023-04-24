Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :forecast, only: [:index]
      get '/salaries', to: 'salaries#index'
    end
  end
end
