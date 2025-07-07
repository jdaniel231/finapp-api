Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"
    },
    defaults: { format: :json }

  namespace :api do
    namespace :v1 do
      resources :clients
      resources :services
      resources :payment_types
      resources :tickets
      resources :account_pays do
        member do
          post :register_payment
          post :cancel_payment
        end
      end
      resources :rede_card_transactions, only: [:create, :index]
    end
  end
end
