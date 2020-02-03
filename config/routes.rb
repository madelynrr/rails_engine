Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      namespace :customers do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get 'random', to: 'random#show'
      end

      namespace :invoice_items do
        get '/find', to: 'find_invoice_items#show'
        get '/find_all', to: 'find_invoice_items#index'
      end

      namespace :invoices do
        get '/find', to: 'find_invoices#show'
        get '/find_all', to: 'find_invoices#index'
      end

      namespace :merchants do
        get '/most_revenue', to: 'merchant_revenue#index'
        get '/revenue', to: 'merchant_revenue#show'
      end

      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
        resources :invoices, only: [:index]
        get '/favorite_customer', to: 'favorite_customer#show'
      end

      resources :items, only: [:index, :show] do
        resources :invoice_items, only: [:index]
        get '/merchant', to: 'merchants#show'
      end

      resources :customers, only: [:index, :show] do
        resources :invoices, only: [:index]
        resources :transactions, only: [:index]
        get 'favorite_merchant', to: 'favorite_merchant#show'
      end

      resources :invoices, only: [:index, :show] do
        resources :transactions, only: [:index]
        resources :invoice_items, only: [:index]
        resources :items, only: [:index]
        get '/customer', to: 'customers#show'
        get '/merchant', to: 'merchants#show'
      end

      resources :transactions, only: [:index, :show] do
        get '/invoice', to: 'invoices#show'
      end

      resources :invoice_items, only: [:index, :show] do
        get '/invoice', to: 'invoices#show'
        get '/item', to: 'items#show'
      end


    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
