Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      namespace :customers do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get 'random', to: 'random#show'
      end

      namespace :merchants do
        get '/most_revenue', to: 'merchants#index'
      end

      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
      end

      resources :items, only: [:index, :show]

      resources :customers, only: [:index, :show] do
        resources :invoices, only: [:index]
        resources :transactions, only: [:index]
        get 'favorite_merchant', to: 'customers#favorite_merchant'
      end

      resources :invoices, only: [:index, :show]

      resources :transactions, only: [:index, :show]

      resources :invoice_items, only: [:index, :show]


    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
