SampleApp::Application.routes.draw do
  get "photos/create"

  get "photos/destroy"

  resources :bnbs do
    resources :bnb_steps, controller: 'bnb_steps'
  end


  resources :bnb_steps


  resources :users
  resources :sessions,   only: [:new, :create, :destroy]
  resources :photos, only: [:create, :destroy]


  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  root to: 'static_pages#home'
  # match '/', to: 'static_pages#home'

  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'

end
