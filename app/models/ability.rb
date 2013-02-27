class Ability
  include CanCan::Ability

  def initialize(user)

   user ||= User.new

    if user.has_role? :owner
      if user.active_subscription.has_expired?
        can :manage, Subscription
      else
       #Bnb
       can :show, Bnb do |bnb|
         bnb.try(:user_id) == user.id
       end
       can :create, Bnb
       can :update, Bnb do |bnb|
         bnb.try(:user_id) ==  user.id
       end
       can :destroy, Bnb do |bnb|
         bnb.try(:user_id) == user.id
       end

       #Rooms
       can :manage, Room, :bnb => { :user_id => user.id }

       #Bookings
       can :manage, Booking, :bnb => { :user_id => user.id}
       can :show, Booking, :bnb => { :user_id => user.id}
       can :confirm, Booking do |bnb|
         bnb.try(:user_id) == user.id
       end
       can :destroy, Booking, :bnb => { :user_id => user.id }

       can :check_in, Booking do |bnb|
         bnb.try(:user_id) == user.id
       end

       can :check_out, Booking do |bnb|
         bnb.try(:user_id) == user.id
       end

       #Guest
       can :manage, Guest, :bnb => {:user_id => user.id }

       #Events
       can :manage, Event

       #LineItems
       can :manage, LineItem

       #Photos
       can :manage, Photo, :processed => false
       can :manage, Photo, :bnb => {:user_id => user.id }
      end
    end

    if user.has_role? :guest
        can :map, Bnb
        can :nearby_bnbs, Bnb
        can :read, Bnb
        can :create, Booking
        can :edit, Booking
        can :update, Booking
        can :show, Booking
        can :my_bookings, Booking
        can :read, Photo
        can :find_available, Room
    elsif user.roles.empty?
        can :read, Bnb
        can :map, Bnb
        can :read, Photo
        can :nearby_bnbs, Bnb
    end
  end

end
