SampleApp::Application.routes.draw do

  resources :rooms, controller: 'rooms', except: [:index]

  resources :bnbs do
    resources :bnb_steps, controller: 'bnb_steps'
    resources :rooms, controller: 'rooms', only: [:index]
  end


  resources :bnb_steps


  resources :users
  resources :sessions,   only: [:new, :create, :destroy]
  resources :photos, only: [:index, :create, :destroy]


  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  root to: 'static_pages#home'
  # match '/', to: 'static_pages#home'

  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'

end
