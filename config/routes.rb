Rails.application.routes.draw do
  devise_for :users,controllers: {
    registrations: "users/registrations"
    }
#  root to: 'posts#index'
  
  root to: 'posts#home'
  resources :users
  resources :posts do
    resources :messages
  end
end
