Bnbeezy::Application.routes.draw do

  root to: 'static_pages#home'

  resources :payment_notifications, only: [:create]

  resources :subscriptions, except: [:index, :edit, :destroy, :update] do
    get :payment_plans, on: :collection
    get :paypal_checkout, on: :collection
  end

  resources :suggestions, only: [:new, :create]
  resources :events, only: [:index]

  devise_for :users, controllers: {sessions: "sessions", registrations: "registrations"}


  namespace :guest do
     resources :bookings, only: [:index]
     resources :bnb, except: :all, shallow: true do
      resources :bookings, except: [:index, :show, :destroy]
     end
  end

  resources :bnbs, shallow: true, except: [:show, :destroy] do
      get :nearby_bnbs, on: :member
      resources :photos, except: [:show]  do
       get :process_image, on: :member
      end
      resources :bookings, shallow: true do
        put :check_out, on: :member
        get :refresh_total, on: :member
        get :show_invoice, on: :member
        get :print_invoice, on: :member
        put :cancel_check_out, on: :member
        put :close, on: :member
        get :confirm, on: :member
        resources :line_items, only: [:create, :update, :destroy]
      end
      resource :setup_wizard, controller: :setup_wizard, only: [:show, :update]
      resources :guests, except: [:show]
      resources :rooms, except: [:show] do
        get :find_available, on: :collection
      end
  end


  get '/bnb(/:id)', to: "bnbs#show", as: 'show_bnb'

  scope controller: :contact do
   get 'new', as: :new_contact
   post 'create', as: :contact
  end


  scope controller: :static_pages do
    get 'startpage'
    get 'admin'
    get 'terms_and_conditions'
    get 'privacypolicy'
    get 'faq'
    get 'help'
    get 'about'
    get 'pricing'
    get 'registration_page'
    get 'ie_warning'
    get 'screens'
  end

  devise_scope :user do
    get "users/signup/:user_role" => "registrations#new", as: 'register'
  end

  match '(errors)/:status', to: 'errors#show', constraints: {status: /\d{3}/}


end
#== Route Map
# Generated on 17 May 2013 15:46
#
#         payment_notifications POST   /payment_notifications(.:format)             payment_notifications#create
#   payment_plans_subscriptions GET    /subscriptions/payment_plans(.:format)       subscriptions#payment_plans
# paypal_checkout_subscriptions GET    /subscriptions/paypal_checkout(.:format)     subscriptions#paypal_checkout
#                 subscriptions POST   /subscriptions(.:format)                     subscriptions#create
#              new_subscription GET    /subscriptions/new(.:format)                 subscriptions#new
#                  subscription GET    /subscriptions/:id(.:format)                 subscriptions#show
#                   suggestions POST   /suggestions(.:format)                       suggestions#create
#                new_suggestion GET    /suggestions/new(.:format)                   suggestions#new
#                        events GET    /events(.:format)                            events#index
#              new_user_session GET    /users/sign_in(.:format)                     sessions#new
#                  user_session POST   /users/sign_in(.:format)                     sessions#create
#          destroy_user_session DELETE /users/sign_out(.:format)                    sessions#destroy
#                 user_password POST   /users/password(.:format)                    devise/passwords#create
#             new_user_password GET    /users/password/new(.:format)                devise/passwords#new
#            edit_user_password GET    /users/password/edit(.:format)               devise/passwords#edit
#                               PUT    /users/password(.:format)                    devise/passwords#update
#      cancel_user_registration GET    /users/cancel(.:format)                      registrations#cancel
#             user_registration POST   /users(.:format)                             registrations#create
#         new_user_registration GET    /users/sign_up(.:format)                     registrations#new
#        edit_user_registration GET    /users/edit(.:format)                        registrations#edit
#                               PUT    /users(.:format)                             registrations#update
#                               DELETE /users(.:format)                             registrations#destroy
#                guest_bookings GET    /guest/bookings(.:format)                    guest/bookings#index
#            guest_bnb_bookings POST   /guest/bnb/:bnb_id/bookings(.:format)        guest/bookings#create
#         new_guest_bnb_booking GET    /guest/bnb/:bnb_id/bookings/new(.:format)    guest/bookings#new
#            edit_guest_booking GET    /guest/bookings/:id/edit(.:format)           guest/bookings#edit
#                 guest_booking PUT    /guest/bookings/:id(.:format)                guest/bookings#update
#               guest_bnb_index GET    /guest/bnb(.:format)                         guest/bnb#index
#                               POST   /guest/bnb(.:format)                         guest/bnb#create
#                 new_guest_bnb GET    /guest/bnb/new(.:format)                     guest/bnb#new
#                edit_guest_bnb GET    /guest/bnb/:id/edit(.:format)                guest/bnb#edit
#                     guest_bnb GET    /guest/bnb/:id(.:format)                     guest/bnb#show
#                               PUT    /guest/bnb/:id(.:format)                     guest/bnb#update
#                               DELETE /guest/bnb/:id(.:format)                     guest/bnb#destroy
#               nearby_bnbs_bnb GET    /bnbs/:id/nearby_bnbs(.:format)              bnbs#nearby_bnbs
#           process_image_photo GET    /photos/:id/process_image(.:format)          photos#process_image
#                    bnb_photos GET    /bnbs/:bnb_id/photos(.:format)               photos#index
#                               POST   /bnbs/:bnb_id/photos(.:format)               photos#create
#                 new_bnb_photo GET    /bnbs/:bnb_id/photos/new(.:format)           photos#new
#                    edit_photo GET    /photos/:id/edit(.:format)                   photos#edit
#                         photo PUT    /photos/:id(.:format)                        photos#update
#                               DELETE /photos/:id(.:format)                        photos#destroy
#             check_out_booking PUT    /bookings/:id/check_out(.:format)            bookings#check_out
#         refresh_total_booking GET    /bookings/:id/refresh_total(.:format)        bookings#refresh_total
#          show_invoice_booking GET    /bookings/:id/show_invoice(.:format)         bookings#show_invoice
#         print_invoice_booking GET    /bookings/:id/print_invoice(.:format)        bookings#print_invoice
#      cancel_check_out_booking PUT    /bookings/:id/cancel_check_out(.:format)     bookings#cancel_check_out
#                 close_booking PUT    /bookings/:id/close(.:format)                bookings#close
#               confirm_booking GET    /bookings/:id/confirm(.:format)              bookings#confirm
#            booking_line_items POST   /bookings/:booking_id/line_items(.:format)   line_items#create
#                     line_item PUT    /line_items/:id(.:format)                    line_items#update
#                               DELETE /line_items/:id(.:format)                    line_items#destroy
#                  bnb_bookings GET    /bnbs/:bnb_id/bookings(.:format)             bookings#index
#                               POST   /bnbs/:bnb_id/bookings(.:format)             bookings#create
#               new_bnb_booking GET    /bnbs/:bnb_id/bookings/new(.:format)         bookings#new
#                  edit_booking GET    /bookings/:id/edit(.:format)                 bookings#edit
#                       booking GET    /bookings/:id(.:format)                      bookings#show
#                               PUT    /bookings/:id(.:format)                      bookings#update
#                               DELETE /bookings/:id(.:format)                      bookings#destroy
#              bnb_setup_wizard GET    /bnbs/:bnb_id/setup_wizard(.:format)         setup_wizard#show
#                               PUT    /bnbs/:bnb_id/setup_wizard(.:format)         setup_wizard#update
#                    bnb_guests GET    /bnbs/:bnb_id/guests(.:format)               guests#index
#                               POST   /bnbs/:bnb_id/guests(.:format)               guests#create
#                 new_bnb_guest GET    /bnbs/:bnb_id/guests/new(.:format)           guests#new
#                    edit_guest GET    /guests/:id/edit(.:format)                   guests#edit
#                         guest PUT    /guests/:id(.:format)                        guests#update
#                               DELETE /guests/:id(.:format)                        guests#destroy
#      find_available_bnb_rooms GET    /bnbs/:bnb_id/rooms/find_available(.:format) rooms#find_available
#                     bnb_rooms GET    /bnbs/:bnb_id/rooms(.:format)                rooms#index
#                               POST   /bnbs/:bnb_id/rooms(.:format)                rooms#create
#                  new_bnb_room GET    /bnbs/:bnb_id/rooms/new(.:format)            rooms#new
#                     edit_room GET    /rooms/:id/edit(.:format)                    rooms#edit
#                          room PUT    /rooms/:id(.:format)                         rooms#update
#                               DELETE /rooms/:id(.:format)                         rooms#destroy
#                          bnbs GET    /bnbs(.:format)                              bnbs#index
#                               POST   /bnbs(.:format)                              bnbs#create
#                       new_bnb GET    /bnbs/new(.:format)                          bnbs#new
#                      edit_bnb GET    /bnbs/:id/edit(.:format)                     bnbs#edit
#                           bnb PUT    /bnbs/:id(.:format)                          bnbs#update
#                      show_bnb GET    /bnb(/:id)(.:format)                         bnbs#show
#                   new_contact GET    /new(.:format)                               contact#new
#                       contact POST   /create(.:format)                            contact#create
#                     startpage GET    /startpage(.:format)                         static_pages#startpage
#                         admin GET    /admin(.:format)                             static_pages#admin
#          terms_and_conditions GET    /terms_and_conditions(.:format)              static_pages#terms_and_conditions
#                 privacypolicy GET    /privacypolicy(.:format)                     static_pages#privacypolicy
#                           faq GET    /faq(.:format)                               static_pages#faq
#                          help GET    /help(.:format)                              static_pages#help
#                         about GET    /about(.:format)                             static_pages#about
#                       pricing GET    /pricing(.:format)                           static_pages#pricing
#             registration_page GET    /registration_page(.:format)                 static_pages#registration_page
#                    ie_warning GET    /ie_warning(.:format)                        static_pages#ie_warning
#                       screens GET    /screens(.:format)                           static_pages#screens
#                      register GET    /users/signup/:user_role(.:format)           registrations#new
#                                      (/errors)/:status(.:format)                  errors#show {:status=>/\d{3}/}
#                  rails_routes        /rails/routes(.:format)                      sextant/routes#index
#                sextant_engine        /sextant                                     Sextant::Engine
# 
# Routes for Sextant::Engine:
