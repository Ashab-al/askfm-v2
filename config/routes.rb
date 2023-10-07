Rails.application.routes.draw do
  devise_for :users
  root 'users#index'

  resources :users, except: [:delete]
  resources :questions, except: [:index, :new, :show]

end
