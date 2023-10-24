Rails.application.routes.draw do
  devise_for :users
  root 'users#index'

  resources :users, except: [:delete]
  resources :questions, except: [:index, :new, :show]

  post 'change_language', to: 'application#change_language', as: :change_language
end
