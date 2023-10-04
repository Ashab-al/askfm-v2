Rails.application.routes.draw do
  root 'users#index'

  resources :users, except: [:delete]
  resources :questions
  
  get 'sign_up' => 'users#new'

end
