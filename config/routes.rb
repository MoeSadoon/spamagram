Rails.application.routes.draw do

  get 'profiles/show'

  devise_for :users, :controllers => { registrations: 'registrations' }
  devise_for :installs

  root 'posts#index'

  resources :posts do
    resources :comments
  end

  get ':username', to: 'profiles#show', as: :profile
  get ':username/edit', to: 'profiles#edit', as: :edit_profile
  patch ':username/edit', to: 'profiles#update', as: :update_profile



end
