Rails.application.routes.draw do
  get 'questions/index'
  get 'questions/show'
  get 'questions/new'
  get 'questions/create'
  get 'questions/edit'
  get 'questions/update'
  get 'questions/destroy'
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/create'
  get 'users/edit'
  get 'users/update'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
