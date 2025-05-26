Rails.application.routes.draw do
 devise_for :users,
             controllers: {
               sessions: "users/sessions",
               registrations: "users/registrations"
             }
  # Outras rotas da sua API
  # Defines the root path route ("/")
  root "initial_page#index"
end
