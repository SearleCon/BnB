SampleApp::Application.routes.draw do


  resources :payment_notifications, controller: 'payment_notification',  only: [:create]

  resources :subscriptions, except: [:index, :edit, :destroy, :update] do
    get :payment_plans, on: :collection
    get :paypal_checkout, on: :collection
  end

  resources :suggestions, only: [:new, :create]
  resources :events, only: [:index]

  devise_for :users, :controllers => {:sessions => "sessions", :registrations => "registrations"}

  resources :bookings do
    get :my_bookings, on: :collection
    resources :line_items, controller: 'line_items', only: [:create, :update, :destroy]
  end

  resources :bnbs, except: [:show] do
    get :nearby_bnbs, on: :member
    resources :photos, only: [:index, :edit, :update, :new, :create, :destroy]  do
     get :process_image, on: :member
    end
    resources :bookings do
      put :check_out, on: :member
      get :refresh_total, on: :member
      get :show_invoice, on: :member
      get :print_pdf, on: :member
      get :tabular_view, on: :collection
      put :cancel_check_out, on: :member
      put :complete_check_out, on: :member
      get :confirm, on: :member
    end
    resources :guests, except: [:show]
    resources :bnb_steps, controller: 'bnb_steps', only: [:show, :update]
    resources :rooms, controller: 'rooms', except: [:show] do
      get :find_available, :on => :collection
    end
  end

  match '/bnbs/sub_region_options', :to => "bnbs#subregions", via: :get

  match '/bnb(/:id)', :to => "bnbs#show", :as => 'show_bnb', via: :get

  match 'contact' => 'contact#new', :as => 'contact', :via => :get
  match 'contact' => 'contact#create', :as => 'contact', :via => :post

  root to: 'static_pages#home'

  match '/startpage', to: 'static_pages#startpage'
  match '/admin', to: 'static_pages#admin'
  match '/terms_and_conditions',  to: 'static_pages#terms_and_conditions'
  match '/privacypolicy', to: 'static_pages#privacy_policy'
  match '/faq', to: 'static_pages#faq'
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contactus', to: 'static_pages#contact'
  match '/pricing', to: 'static_pages#pricing'
  match '/registration_page', to: 'static_pages#registration_page'
  match '/ie_warning', to: 'static_pages#ie_warning'
  match '/screens', to: 'static_pages#screens'

  devise_scope :user do
    match "users/signup/:user_role" => "registrations#new", as: 'register'
  end

end
#== Route Map
# Generated on 11 Apr 2013 16:04
#
#    payment_plans_subscriptions GET    /subscriptions/payment_plans(.:format)                  subscriptions#payment_plans
#  paypal_checkout_subscriptions GET    /subscriptions/paypal_checkout(.:format)                subscriptions#paypal_checkout
#                  subscriptions POST   /subscriptions(.:format)                                subscriptions#create
#               new_subscription GET    /subscriptions/new(.:format)                            subscriptions#new
#                   subscription GET    /subscriptions/:id(.:format)                            subscriptions#show
#                    suggestions POST   /suggestions(.:format)                                  suggestions#create
#                 new_suggestion GET    /suggestions/new(.:format)                              suggestions#new
#                         events GET    /events(.:format)                                       events#index
#               new_user_session GET    /users/sign_in(.:format)                                sessions#new
#                   user_session POST   /users/sign_in(.:format)                                sessions#create
#           destroy_user_session DELETE /users/sign_out(.:format)                               sessions#destroy
#                  user_password POST   /users/password(.:format)                               devise/passwords#create
#              new_user_password GET    /users/password/new(.:format)                           devise/passwords#new
#             edit_user_password GET    /users/password/edit(.:format)                          devise/passwords#edit
#                                PUT    /users/password(.:format)                               devise/passwords#update
#       cancel_user_registration GET    /users/cancel(.:format)                                 registrations#cancel
#              user_registration POST   /users(.:format)                                        registrations#create
#          new_user_registration GET    /users/sign_up(.:format)                                registrations#new
#         edit_user_registration GET    /users/edit(.:format)                                   registrations#edit
#                                PUT    /users(.:format)                                        registrations#update
#                                DELETE /users(.:format)                                        registrations#destroy
#           my_bookings_bookings GET    /bookings/my_bookings(.:format)                         bookings#my_bookings
#             booking_line_items POST   /bookings/:booking_id/line_items(.:format)              line_items#create
#              booking_line_item PUT    /bookings/:booking_id/line_items/:id(.:format)          line_items#update
#                                DELETE /bookings/:booking_id/line_items/:id(.:format)          line_items#destroy
#                       bookings GET    /bookings(.:format)                                     bookings#index
#                                POST   /bookings(.:format)                                     bookings#create
#                    new_booking GET    /bookings/new(.:format)                                 bookings#new
#                   edit_booking GET    /bookings/:id/edit(.:format)                            bookings#edit
#                        booking GET    /bookings/:id(.:format)                                 bookings#show
#                                PUT    /bookings/:id(.:format)                                 bookings#update
#                                DELETE /bookings/:id(.:format)                                 bookings#destroy
#                nearby_bnbs_bnb GET    /bnbs/:id/nearby_bnbs(.:format)                         bnbs#nearby_bnbs
#        process_image_bnb_photo GET    /bnbs/:bnb_id/photos/:id/process_image(.:format)        photos#process_image
#                     bnb_photos GET    /bnbs/:bnb_id/photos(.:format)                          photos#index
#                                POST   /bnbs/:bnb_id/photos(.:format)                          photos#create
#                  new_bnb_photo GET    /bnbs/:bnb_id/photos/new(.:format)                      photos#new
#                 edit_bnb_photo GET    /bnbs/:bnb_id/photos/:id/edit(.:format)                 photos#edit
#                      bnb_photo PUT    /bnbs/:bnb_id/photos/:id(.:format)                      photos#update
#                                DELETE /bnbs/:bnb_id/photos/:id(.:format)                      photos#destroy
#          check_out_bnb_booking PUT    /bnbs/:bnb_id/bookings/:id/check_out(.:format)          bookings#check_out
#      refresh_total_bnb_booking GET    /bnbs/:bnb_id/bookings/:id/refresh_total(.:format)      bookings#refresh_total
#       show_invoice_bnb_booking GET    /bnbs/:bnb_id/bookings/:id/show_invoice(.:format)       bookings#show_invoice
#          print_pdf_bnb_booking GET    /bnbs/:bnb_id/bookings/:id/print_pdf(.:format)          bookings#print_pdf
#      tabular_view_bnb_bookings GET    /bnbs/:bnb_id/bookings/tabular_view(.:format)           bookings#tabular_view
#   cancel_check_out_bnb_booking PUT    /bnbs/:bnb_id/bookings/:id/cancel_check_out(.:format)   bookings#cancel_check_out
# complete_check_out_bnb_booking PUT    /bnbs/:bnb_id/bookings/:id/complete_check_out(.:format) bookings#complete_check_out
#            confirm_bnb_booking GET    /bnbs/:bnb_id/bookings/:id/confirm(.:format)            bookings#confirm
#                   bnb_bookings GET    /bnbs/:bnb_id/bookings(.:format)                        bookings#index
#                                POST   /bnbs/:bnb_id/bookings(.:format)                        bookings#create
#                new_bnb_booking GET    /bnbs/:bnb_id/bookings/new(.:format)                    bookings#new
#               edit_bnb_booking GET    /bnbs/:bnb_id/bookings/:id/edit(.:format)               bookings#edit
#                    bnb_booking GET    /bnbs/:bnb_id/bookings/:id(.:format)                    bookings#show
#                                PUT    /bnbs/:bnb_id/bookings/:id(.:format)                    bookings#update
#                                DELETE /bnbs/:bnb_id/bookings/:id(.:format)                    bookings#destroy
#                     bnb_guests GET    /bnbs/:bnb_id/guests(.:format)                          guests#index
#                                POST   /bnbs/:bnb_id/guests(.:format)                          guests#create
#                  new_bnb_guest GET    /bnbs/:bnb_id/guests/new(.:format)                      guests#new
#                 edit_bnb_guest GET    /bnbs/:bnb_id/guests/:id/edit(.:format)                 guests#edit
#                      bnb_guest PUT    /bnbs/:bnb_id/guests/:id(.:format)                      guests#update
#                                DELETE /bnbs/:bnb_id/guests/:id(.:format)                      guests#destroy
#                   bnb_bnb_step GET    /bnbs/:bnb_id/bnb_steps/:id(.:format)                   bnb_steps#show
#                                PUT    /bnbs/:bnb_id/bnb_steps/:id(.:format)                   bnb_steps#update
#       find_available_bnb_rooms GET    /bnbs/:bnb_id/rooms/find_available(.:format)            rooms#find_available
#                      bnb_rooms GET    /bnbs/:bnb_id/rooms(.:format)                           rooms#index
#                                POST   /bnbs/:bnb_id/rooms(.:format)                           rooms#create
#                   new_bnb_room GET    /bnbs/:bnb_id/rooms/new(.:format)                       rooms#new
#                  edit_bnb_room GET    /bnbs/:bnb_id/rooms/:id/edit(.:format)                  rooms#edit
#                       bnb_room PUT    /bnbs/:bnb_id/rooms/:id(.:format)                       rooms#update
#                                DELETE /bnbs/:bnb_id/rooms/:id(.:format)                       rooms#destroy
#                           bnbs GET    /bnbs(.:format)                                         bnbs#index
#                                POST   /bnbs(.:format)                                         bnbs#create
#                        new_bnb GET    /bnbs/new(.:format)                                     bnbs#new
#                       edit_bnb GET    /bnbs/:id/edit(.:format)                                bnbs#edit
#                            bnb PUT    /bnbs/:id(.:format)                                     bnbs#update
#                                DELETE /bnbs/:id(.:format)                                     bnbs#destroy
#        bnbs_sub_region_options GET    /bnbs/sub_region_options(.:format)                      bnbs#subregions
#                       show_bnb GET    /bnb(/:id)(.:format)                                    bnbs#show
#                        contact GET    /contact(.:format)                                      contact#new
#                        contact POST   /contact(.:format)                                      contact#create
#                           root        /                                                       static_pages#home
#                      startpage        /startpage(.:format)                                    static_pages#startpage
#           terms_and_conditions        /terms_and_conditions(.:format)                         static_pages#terms_and_conditions
#                  privacypolicy        /privacypolicy(.:format)                                static_pages#privacy_policy
#                            faq        /faq(.:format)                                          static_pages#faq
#                           help        /help(.:format)                                         static_pages#help
#                          about        /about(.:format)                                        static_pages#about
#                      contactus        /contactus(.:format)                                    static_pages#contact
#                        pricing        /pricing(.:format)                                      static_pages#pricing
#              registration_page        /registration_page(.:format)                            static_pages#registration_page
#                     ie_warning        /ie_warning(.:format)                                   static_pages#ie_warning
#                        screens        /screens(.:format)                                      static_pages#screens
#                       register        /users/signup/:user_role(.:format)                      registrations#new
#                                       /*path(.:format)                                        application#routing_error
