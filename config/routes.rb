SampleApp::Application.routes.draw do


  resources :payment_notifications, controller: 'payment_notification',  only: [:create]

  resources :subscriptions do
    get :payment_plans, on: :collection
  end

  resources :suggestions
  resources :events, only: [:index]

  devise_for :users, :controllers => {:sessions => "sessions", :registrations => "registrations"}

  resources :bookings do
    get :my_bookings, on: :collection
    resources :events, only: [:update]
    resources :line_items, controller: 'line_items', only: [:create, :update, :destroy]
  end

  resources :bnbs, except: [:show] do
    get :map, on: :collection
    get :nearby_bnbs, on: :member
    resources :photos, only: [:index, :new, :create, :destroy]
    resources :bookings do
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

  match '/startpage', to: 'static_pages#startpage'
  match '/terms_and_conditions',  to: 'static_pages#terms_and_conditions'
  match '/privacypolicy', to: 'static_pages#privacy_policy'
  match '/faq', to: 'static_pages#faq'
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contactus', to: 'static_pages#contact'

  get "paypal/checkout", to: "subscriptions#paypal_checkout"


  devise_scope :user do
    match "users/signup/:user_role" => "registrations#new", as: 'register'
  end

  match "*path", :to => "application#routing_error"

end
#== Route Map
# Generated on 21 Nov 2012 12:24
#
# payment_plans_subscriptions GET    /subscriptions/payment_plans(.:format)             subscriptions#payment_plans
#               subscriptions GET    /subscriptions(.:format)                           subscriptions#index
#                             POST   /subscriptions(.:format)                           subscriptions#create
#            new_subscription GET    /subscriptions/new(.:format)                       subscriptions#new
#           edit_subscription GET    /subscriptions/:id/edit(.:format)                  subscriptions#edit
#                subscription GET    /subscriptions/:id(.:format)                       subscriptions#show
#                             PUT    /subscriptions/:id(.:format)                       subscriptions#update
#                             DELETE /subscriptions/:id(.:format)                       subscriptions#destroy
#                 suggestions GET    /suggestions(.:format)                             suggestions#index
#                             POST   /suggestions(.:format)                             suggestions#create
#              new_suggestion GET    /suggestions/new(.:format)                         suggestions#new
#             edit_suggestion GET    /suggestions/:id/edit(.:format)                    suggestions#edit
#                  suggestion GET    /suggestions/:id(.:format)                         suggestions#show
#                             PUT    /suggestions/:id(.:format)                         suggestions#update
#                             DELETE /suggestions/:id(.:format)                         suggestions#destroy
#                      events GET    /events(.:format)                                  events#index
#            new_user_session GET    /users/sign_in(.:format)                           sessions#new
#                user_session POST   /users/sign_in(.:format)                           sessions#create
#        destroy_user_session DELETE /users/sign_out(.:format)                          sessions#destroy
#               user_password POST   /users/password(.:format)                          devise/passwords#create
#           new_user_password GET    /users/password/new(.:format)                      devise/passwords#new
#          edit_user_password GET    /users/password/edit(.:format)                     devise/passwords#edit
#                             PUT    /users/password(.:format)                          devise/passwords#update
#    cancel_user_registration GET    /users/cancel(.:format)                            registrations#cancel
#           user_registration POST   /users(.:format)                                   registrations#create
#       new_user_registration GET    /users/sign_up(.:format)                           registrations#new
#      edit_user_registration GET    /users/edit(.:format)                              registrations#edit
#                             PUT    /users(.:format)                                   registrations#update
#                             DELETE /users(.:format)                                   registrations#destroy
#        my_bookings_bookings GET    /bookings/my_bookings(.:format)                    bookings#my_bookings
#               booking_event PUT    /bookings/:booking_id/events/:id(.:format)         events#update
#          booking_line_items POST   /bookings/:booking_id/line_items(.:format)         line_items#create
#           booking_line_item PUT    /bookings/:booking_id/line_items/:id(.:format)     line_items#update
#                             DELETE /bookings/:booking_id/line_items/:id(.:format)     line_items#destroy
#                    bookings GET    /bookings(.:format)                                bookings#index
#                             POST   /bookings(.:format)                                bookings#create
#                 new_booking GET    /bookings/new(.:format)                            bookings#new
#                edit_booking GET    /bookings/:id/edit(.:format)                       bookings#edit
#                     booking GET    /bookings/:id(.:format)                            bookings#show
#                             PUT    /bookings/:id(.:format)                            bookings#update
#                             DELETE /bookings/:id(.:format)                            bookings#destroy
#                    map_bnbs GET    /bnbs/map(.:format)                                bnbs#map
#             nearby_bnbs_bnb GET    /bnbs/:id/nearby_bnbs(.:format)                    bnbs#nearby_bnbs
#                  bnb_photos GET    /bnbs/:bnb_id/photos(.:format)                     photos#index
#                             POST   /bnbs/:bnb_id/photos(.:format)                     photos#create
#               new_bnb_photo GET    /bnbs/:bnb_id/photos/new(.:format)                 photos#new
#                   bnb_photo DELETE /bnbs/:bnb_id/photos/:id(.:format)                 photos#destroy
#        check_in_bnb_booking PUT    /bnbs/:bnb_id/bookings/:id/check_in(.:format)      bookings#check_in
#       check_out_bnb_booking PUT    /bnbs/:bnb_id/bookings/:id/check_out(.:format)     bookings#check_out
#         confirm_bnb_booking PUT    /bnbs/:bnb_id/bookings/:id/confirm(.:format)       bookings#confirm
#   refresh_total_bnb_booking GET    /bnbs/:bnb_id/bookings/:id/refresh_total(.:format) bookings#refresh_total
#    show_invoice_bnb_booking GET    /bnbs/:bnb_id/bookings/:id/show_invoice(.:format)  bookings#show_invoice
#       print_pdf_bnb_booking GET    /bnbs/:bnb_id/bookings/:id/print_pdf(.:format)     bookings#print_pdf
#                bnb_bookings GET    /bnbs/:bnb_id/bookings(.:format)                   bookings#index
#                             POST   /bnbs/:bnb_id/bookings(.:format)                   bookings#create
#             new_bnb_booking GET    /bnbs/:bnb_id/bookings/new(.:format)               bookings#new
#            edit_bnb_booking GET    /bnbs/:bnb_id/bookings/:id/edit(.:format)          bookings#edit
#                 bnb_booking GET    /bnbs/:bnb_id/bookings/:id(.:format)               bookings#show
#                             PUT    /bnbs/:bnb_id/bookings/:id(.:format)               bookings#update
#                             DELETE /bnbs/:bnb_id/bookings/:id(.:format)               bookings#destroy
#                  bnb_guests GET    /bnbs/:bnb_id/guests(.:format)                     guests#index
#                             POST   /bnbs/:bnb_id/guests(.:format)                     guests#create
#               new_bnb_guest GET    /bnbs/:bnb_id/guests/new(.:format)                 guests#new
#              edit_bnb_guest GET    /bnbs/:bnb_id/guests/:id/edit(.:format)            guests#edit
#                   bnb_guest GET    /bnbs/:bnb_id/guests/:id(.:format)                 guests#show
#                             PUT    /bnbs/:bnb_id/guests/:id(.:format)                 guests#update
#                             DELETE /bnbs/:bnb_id/guests/:id(.:format)                 guests#destroy
#                bnb_bnb_step GET    /bnbs/:bnb_id/bnb_steps/:id(.:format)              bnb_steps#show
#                             PUT    /bnbs/:bnb_id/bnb_steps/:id(.:format)              bnb_steps#update
#    find_available_bnb_rooms GET    /bnbs/:bnb_id/rooms/find_available(.:format)       rooms#find_available
#                   bnb_rooms GET    /bnbs/:bnb_id/rooms(.:format)                      rooms#index
#                             POST   /bnbs/:bnb_id/rooms(.:format)                      rooms#create
#                new_bnb_room GET    /bnbs/:bnb_id/rooms/new(.:format)                  rooms#new
#               edit_bnb_room GET    /bnbs/:bnb_id/rooms/:id/edit(.:format)             rooms#edit
#                    bnb_room PUT    /bnbs/:bnb_id/rooms/:id(.:format)                  rooms#update
#                             DELETE /bnbs/:bnb_id/rooms/:id(.:format)                  rooms#destroy
#                        bnbs GET    /bnbs(.:format)                                    bnbs#index
#                             POST   /bnbs(.:format)                                    bnbs#create
#                     new_bnb GET    /bnbs/new(.:format)                                bnbs#new
#                    edit_bnb GET    /bnbs/:id/edit(.:format)                           bnbs#edit
#                         bnb PUT    /bnbs/:id(.:format)                                bnbs#update
#                             DELETE /bnbs/:id(.:format)                                bnbs#destroy
#     bnbs_sub_region_options GET    /bnbs/sub_region_options(.:format)                 bnbs#subregions
#                    show_bnb GET    /bnb(/:id)(.:format)                               bnbs#show
#                  line_items POST   /line_items(.:format)                              line_items#create
#                   line_item DELETE /line_items/:id(.:format)                          line_items#destroy
#                     contact GET    /contact(.:format)                                 contact#new
#                  contactbnb GET    /contact/:bnb_id(.:format)                         contact#new
#                     contact POST   /contact(.:format)                                 contact#create
#                  contactbnb POST   /contact/:bnb_id(.:format)                         contact#create
#                        root        /                                                  static_pages#home
#                   startpage        /startpage(.:format)                               static_pages#startpage
#        terms_and_conditions        /terms_and_conditions(.:format)                    static_pages#terms_and_conditions
#               privacypolicy        /privacypolicy(.:format)                           static_pages#privacy_policy
#                         faq        /faq(.:format)                                     static_pages#faq
#                        help        /help(.:format)                                    static_pages#help
#                       about        /about(.:format)                                   static_pages#about
#                   contactus        /contactus(.:format)                               static_pages#contact
#             paypal_checkout GET    /paypal/checkout(.:format)                         subscriptions#paypal_checkout
#                    register        /users/signup/:user_role(.:format)                 registrations#new
#                                    /*path(.:format)                                   application#routing_error
