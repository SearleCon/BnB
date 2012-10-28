SampleApp::Application.routes.draw do

  resources :suggestions

  devise_for :users, :controllers => {:sessions => "sessions"}

  resources :bookings do
    resources :line_items, controller: 'line_items', only: [:create, :update, :destroy]
    put :check_in, on: :member
    put :check_out, on: :member
    put :confirm, on: :member
    get :refresh_total, on: :member
    get :show_invoice, on: :member
    get :print_pdf, on: :member
    get :my_bookings, on: :collection
  end

  resources :events, only: [:index, :update] do
    get :filter_by_status, on: :collection
  end

  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  resources :bnbs, except: [:show] do
    get :map, on: :collection
    get :nearby_bnbs, on: :member
    resources :events, only: [:index]
    resources :photos, only: [:index, :new, :create, :destroy]
    resources :bookings do
      resources :line_items, controller: 'line_items', only: [:create, :update, :destroy]
      put :check_in, on: :member
      put :check_out, on: :member
      put :confirm, on: :member
      get :refresh_total, on: :member
      get :show_invoice, on: :member
      get :print_pdf, on: :member
    end
    resources :guests
    resources :bnb_steps, controller: 'bnb_steps', only: [:show, :update]
    resources :rooms, controller: 'rooms', except: [:show] do
      get :find_available, :on => :collection
    end
  end

  match '/bnbs/sub_region_options', :to => "bnbs#subregions", via: :get

  match '/bnb(/:id)', :to => "bnbs#show", :as => 'show_bnb', via: :get

  resources :line_items, controller: 'line_items', only: [:create, :destroy]

  match 'contact' => 'contact#new', :as => 'contact', :via => :get
  match 'contact/:bnb_id' => 'contact#new', :as => 'contactbnb', :via => :get
  match 'contact' => 'contact#create', :as => 'contact', :via => :post
  match 'contact/:bnb_id' => 'contact#create', :as => 'contactbnb', :via => :post

  root to: 'static_pages#home'
  # match '/', to: 'static_pages#home'

  match '/terms_and_conditions',  to: 'static_pages#terms_and_conditions'
  match '/privacypolicy', to: 'static_pages#privacy_policy'
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contactus', to: 'static_pages#contact'

  match "*path", :to => "application#routing_error"

end
#== Route Map
# Generated on 24 Oct 2012 11:13
#
#                           POST   /suggestions(.:format)                                      suggestions#create
#            new_suggestion GET    /suggestions/new(.:format)                                  suggestions#new
#           edit_suggestion GET    /suggestions/:id/edit(.:format)                             suggestions#edit
#                suggestion GET    /suggestions/:id(.:format)                                  suggestions#show
#                           PUT    /suggestions/:id(.:format)                                  suggestions#update
#                           DELETE /suggestions/:id(.:format)                                  suggestions#destroy
#          new_user_session GET    /users/sign_in(.:format)                                    sessions#new
#              user_session POST   /users/sign_in(.:format)                                    sessions#create
#      destroy_user_session DELETE /users/sign_out(.:format)                                   sessions#destroy
#             user_password POST   /users/password(.:format)                                   devise/passwords#create
#         new_user_password GET    /users/password/new(.:format)                               devise/passwords#new
#        edit_user_password GET    /users/password/edit(.:format)                              devise/passwords#edit
#                           PUT    /users/password(.:format)                                   devise/passwords#update
#  cancel_user_registration GET    /users/cancel(.:format)                                     devise/registrations#cancel
#         user_registration POST   /users(.:format)                                            devise/registrations#create
#     new_user_registration GET    /users/sign_up(.:format)                                    devise/registrations#new
#    edit_user_registration GET    /users/edit(.:format)                                       devise/registrations#edit
#                           PUT    /users(.:format)                                            devise/registrations#update
#                           DELETE /users(.:format)                                            devise/registrations#destroy
#        booking_line_items POST   /bookings/:booking_id/line_items(.:format)                  line_items#create
#         booking_line_item PUT    /bookings/:booking_id/line_items/:id(.:format)              line_items#update
#                           DELETE /bookings/:booking_id/line_items/:id(.:format)              line_items#destroy
#          check_in_booking PUT    /bookings/:id/check_in(.:format)                            bookings#check_in
#         check_out_booking PUT    /bookings/:id/check_out(.:format)                           bookings#check_out
#           confirm_booking PUT    /bookings/:id/confirm(.:format)                             bookings#confirm
#     refresh_total_booking GET    /bookings/:id/refresh_total(.:format)                       bookings#refresh_total
#      show_invoice_booking GET    /bookings/:id/show_invoice(.:format)                        bookings#show_invoice
#         print_pdf_booking GET    /bookings/:id/print_pdf(.:format)                           bookings#print_pdf
#      my_bookings_bookings GET    /bookings/my_bookings(.:format)                             bookings#my_bookings
#                  bookings GET    /bookings(.:format)                                         bookings#index
#                           POST   /bookings(.:format)                                         bookings#create
#               new_booking GET    /bookings/new(.:format)                                     bookings#new
#              edit_booking GET    /bookings/:id/edit(.:format)                                bookings#edit
#                   booking GET    /bookings/:id(.:format)                                     bookings#show
#                           PUT    /bookings/:id(.:format)                                     bookings#update
#                           DELETE /bookings/:id(.:format)                                     bookings#destroy
#   filter_by_status_events GET    /events/filter_by_status(.:format)                          events#filter_by_status
#                    events GET    /events(.:format)                                           events#index
#                     event PUT    /events/:id(.:format)                                       events#update
#                  calendar        /calendar(/:year(/:month))(.:format)                        calendar#index {:year=>/\d{4}/, :month=>/\d{1,2}/}
#                bnb_events GET    /bnbs/:bnb_id/events(.:format)                              events#index
#                bnb_photos GET    /bnbs/:bnb_id/photos(.:format)                              photos#index
#                           POST   /bnbs/:bnb_id/photos(.:format)                              photos#create
#             new_bnb_photo GET    /bnbs/:bnb_id/photos/new(.:format)                          photos#new
#                 bnb_photo DELETE /bnbs/:bnb_id/photos/:id(.:format)                          photos#destroy
#    bnb_booking_line_items POST   /bnbs/:bnb_id/bookings/:booking_id/line_items(.:format)     line_items#create
#     bnb_booking_line_item PUT    /bnbs/:bnb_id/bookings/:booking_id/line_items/:id(.:format) line_items#update
#                           DELETE /bnbs/:bnb_id/bookings/:booking_id/line_items/:id(.:format) line_items#destroy
#      check_in_bnb_booking PUT    /bnbs/:bnb_id/bookings/:id/check_in(.:format)               bookings#check_in
#     check_out_bnb_booking PUT    /bnbs/:bnb_id/bookings/:id/check_out(.:format)              bookings#check_out
#       confirm_bnb_booking PUT    /bnbs/:bnb_id/bookings/:id/confirm(.:format)                bookings#confirm
# refresh_total_bnb_booking GET    /bnbs/:bnb_id/bookings/:id/refresh_total(.:format)          bookings#refresh_total
#  show_invoice_bnb_booking GET    /bnbs/:bnb_id/bookings/:id/show_invoice(.:format)           bookings#show_invoice
#     print_pdf_bnb_booking GET    /bnbs/:bnb_id/bookings/:id/print_pdf(.:format)              bookings#print_pdf
#              bnb_bookings GET    /bnbs/:bnb_id/bookings(.:format)                            bookings#index
#                           POST   /bnbs/:bnb_id/bookings(.:format)                            bookings#create
#           new_bnb_booking GET    /bnbs/:bnb_id/bookings/new(.:format)                        bookings#new
#          edit_bnb_booking GET    /bnbs/:bnb_id/bookings/:id/edit(.:format)                   bookings#edit
#               bnb_booking GET    /bnbs/:bnb_id/bookings/:id(.:format)                        bookings#show
#                           PUT    /bnbs/:bnb_id/bookings/:id(.:format)                        bookings#update
#                           DELETE /bnbs/:bnb_id/bookings/:id(.:format)                        bookings#destroy
#                bnb_guests GET    /bnbs/:bnb_id/guests(.:format)                              guests#index
#                           POST   /bnbs/:bnb_id/guests(.:format)                              guests#create
#             new_bnb_guest GET    /bnbs/:bnb_id/guests/new(.:format)                          guests#new
#            edit_bnb_guest GET    /bnbs/:bnb_id/guests/:id/edit(.:format)                     guests#edit
#                 bnb_guest GET    /bnbs/:bnb_id/guests/:id(.:format)                          guests#show
#                           PUT    /bnbs/:bnb_id/guests/:id(.:format)                          guests#update
#                           DELETE /bnbs/:bnb_id/guests/:id(.:format)                          guests#destroy
#              bnb_bnb_step GET    /bnbs/:bnb_id/bnb_steps/:id(.:format)                       bnb_steps#show
#                           PUT    /bnbs/:bnb_id/bnb_steps/:id(.:format)                       bnb_steps#update
#  find_available_bnb_rooms GET    /bnbs/:bnb_id/rooms/find_available(.:format)                rooms#find_available
#                 bnb_rooms GET    /bnbs/:bnb_id/rooms(.:format)                               rooms#index
#                           POST   /bnbs/:bnb_id/rooms(.:format)                               rooms#create
#              new_bnb_room GET    /bnbs/:bnb_id/rooms/new(.:format)                           rooms#new
#             edit_bnb_room GET    /bnbs/:bnb_id/rooms/:id/edit(.:format)                      rooms#edit
#                  bnb_room PUT    /bnbs/:bnb_id/rooms/:id(.:format)                           rooms#update
#                           DELETE /bnbs/:bnb_id/rooms/:id(.:format)                           rooms#destroy
#                      bnbs GET    /bnbs(.:format)                                             bnbs#index
#                           POST   /bnbs(.:format)                                             bnbs#create
#                   new_bnb GET    /bnbs/new(.:format)                                         bnbs#new
#                  edit_bnb GET    /bnbs/:id/edit(.:format)                                    bnbs#edit
#                       bnb PUT    /bnbs/:id(.:format)                                         bnbs#update
#                           DELETE /bnbs/:id(.:format)                                         bnbs#destroy
#   bnbs_sub_region_options GET    /bnbs/sub_region_options(.:format)                          bnbs#subregions
#                  show_bnb GET    /bnb(/:id)(.:format)                                        bnbs#show
#                line_items POST   /line_items(.:format)                                       line_items#create
#                 line_item DELETE /line_items/:id(.:format)                                   line_items#destroy
#                   contact GET    /contact(.:format)                                          contact#new
#                contactbnb GET    /contact/:bnb_id(.:format)                                  contact#new
#                   contact POST   /contact(.:format)                                          contact#create
#                contactbnb POST   /contact/:bnb_id(.:format)                                  contact#create
#                      root        /                                                           static_pages#home
#      terms_and_conditions        /terms_and_conditions(.:format)                             static_pages#terms_and_conditions
#             privacypolicy        /privacypolicy(.:format)                                    static_pages#privacy_policy
#                      help        /help(.:format)                                             static_pages#help
#                     about        /about(.:format)                                            static_pages#about
#                 contactus        /contactus(.:format)                                        static_pages#contact
#                                  /*path(.:format)                                            application#routing_error
