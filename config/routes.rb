SampleApp::Application.routes.draw do

  devise_for :users

  resources :bookings do
    resources :line_items, controller: 'line_items', only: [:create, :update, :destroy]
    put :check_in, on: :member
    put :check_out, on: :member
    put :confirm, on: :member
    get :refresh_total, on: :member
    get :show_invoice, on: :member
  end

  resources :guests

  resources :events, only: [:index, :update] do
    get :filter_by_status, on: :collection
  end

  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  resources :rooms, controller: 'rooms', except: [:index]  do
    get :find_available, :on => :collection
  end

  resources :bnbs, except: [:show] do
    resources :bookings, only: [:new, :create]
    resources :bnb_steps, controller: 'bnb_steps', only: [:show, :update]
    resources :rooms, controller: 'rooms', only: [:index]
  end

  match '/bnb(/:id)', :to => "bnbs#show", :as => 'show_bnb', via: :get

  resources :line_items, controller: 'line_items', only: [:create, :destroy]

  resources :photos, only: [:index, :create, :destroy]


  match 'contact' => 'contact#new', :as => 'contact', :via => :get
  match 'contact/:bnb_id' => 'contact#new', :as => 'contactbnb', :via => :get
  match 'contact' => 'contact#create', :as => 'contact', :via => :post
  match 'contact/:bnb_id' => 'contact#create', :as => 'contactbnb', :via => :post

  root to: 'static_pages#home'
  # match '/', to: 'static_pages#home'

  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contactus', to: 'static_pages#contact'

end
#== Route Map
# Generated on 07 Aug 2012 10:33
#
#                   POST   /bookings(.:format)                        bookings#create
#       new_booking GET    /bookings/new(.:format)                    bookings#new
#      edit_booking GET    /bookings/:id/edit(.:format)               bookings#edit
#           booking GET    /bookings/:id(.:format)                    bookings#show
#                   PUT    /bookings/:id(.:format)                    bookings#update
#                   DELETE /bookings/:id(.:format)                    bookings#destroy
#            guests GET    /guests(.:format)                          guests#index
#                   POST   /guests(.:format)                          guests#create
#         new_guest GET    /guests/new(.:format)                      guests#new
#        edit_guest GET    /guests/:id/edit(.:format)                 guests#edit
#             guest GET    /guests/:id(.:format)                      guests#show
#                   PUT    /guests/:id(.:format)                      guests#update
#                   DELETE /guests/:id(.:format)                      guests#destroy
#            events GET    /events(.:format)                          events#index
#                   POST   /events(.:format)                          events#create
#         new_event GET    /events/new(.:format)                      events#new
#        edit_event GET    /events/:id/edit(.:format)                 events#edit
#             event GET    /events/:id(.:format)                      events#show
#                   PUT    /events/:id(.:format)                      events#update
#                   DELETE /events/:id(.:format)                      events#destroy
#          calendar        /calendar(/:year(/:month))(.:format)       calendar#index {:year=>/\d{4}/, :month=>/\d{1,2}/}
#             rooms POST   /rooms(.:format)                           rooms#create
#          new_room GET    /rooms/new(.:format)                       rooms#new
#         edit_room GET    /rooms/:id/edit(.:format)                  rooms#edit
#              room GET    /rooms/:id(.:format)                       rooms#show
#                   PUT    /rooms/:id(.:format)                       rooms#update
#                   DELETE /rooms/:id(.:format)                       rooms#destroy
#     bnb_bnb_steps GET    /bnbs/:bnb_id/bnb_steps(.:format)          bnb_steps#index
#                   POST   /bnbs/:bnb_id/bnb_steps(.:format)          bnb_steps#create
#  new_bnb_bnb_step GET    /bnbs/:bnb_id/bnb_steps/new(.:format)      bnb_steps#new
# edit_bnb_bnb_step GET    /bnbs/:bnb_id/bnb_steps/:id/edit(.:format) bnb_steps#edit
#      bnb_bnb_step GET    /bnbs/:bnb_id/bnb_steps/:id(.:format)      bnb_steps#show
#                   PUT    /bnbs/:bnb_id/bnb_steps/:id(.:format)      bnb_steps#update
#                   DELETE /bnbs/:bnb_id/bnb_steps/:id(.:format)      bnb_steps#destroy
#         bnb_rooms GET    /bnbs/:bnb_id/rooms(.:format)              rooms#index
#              bnbs GET    /bnbs(.:format)                            bnbs#index
#                   POST   /bnbs(.:format)                            bnbs#create
#           new_bnb GET    /bnbs/new(.:format)                        bnbs#new
#          edit_bnb GET    /bnbs/:id/edit(.:format)                   bnbs#edit
#               bnb GET    /bnbs/:id(.:format)                        bnbs#show
#                   PUT    /bnbs/:id(.:format)                        bnbs#update
#                   DELETE /bnbs/:id(.:format)                        bnbs#destroy
#         bnb_steps GET    /bnb_steps(.:format)                       bnb_steps#index
#                   POST   /bnb_steps(.:format)                       bnb_steps#create
#      new_bnb_step GET    /bnb_steps/new(.:format)                   bnb_steps#new
#     edit_bnb_step GET    /bnb_steps/:id/edit(.:format)              bnb_steps#edit
#          bnb_step GET    /bnb_steps/:id(.:format)                   bnb_steps#show
#                   PUT    /bnb_steps/:id(.:format)                   bnb_steps#update
#                   DELETE /bnb_steps/:id(.:format)                   bnb_steps#destroy
#             users GET    /users(.:format)                           users#index
#                   POST   /users(.:format)                           users#create
#          new_user GET    /users/new(.:format)                       users#new
#         edit_user GET    /users/:id/edit(.:format)                  users#edit
#              user GET    /users/:id(.:format)                       users#show
#                   PUT    /users/:id(.:format)                       users#update
#                   DELETE /users/:id(.:format)                       users#destroy
#          sessions POST   /sessions(.:format)                        sessions#create
#       new_session GET    /sessions/new(.:format)                    sessions#new
#           session DELETE /sessions/:id(.:format)                    sessions#destroy
#            photos GET    /photos(.:format)                          photos#index
#                   POST   /photos(.:format)                          photos#create
#             photo DELETE /photos/:id(.:format)                      photos#destroy
#            signup        /signup(.:format)                          users#new
#            signin        /signin(.:format)                          sessions#new
#           signout DELETE /signout(.:format)                         sessions#destroy
#              root        /                                          static_pages#home
#              help        /help(.:format)                            static_pages#help
#             about        /about(.:format)                           static_pages#about
#           contact        /contact(.:format)                         static_pages#contact
