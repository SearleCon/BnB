class Ability
  include CanCan::Ability

  def initialize(user)

   user ||= User.new


    case user.role.description
      when 'Owner'
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
             can :manage, Photo, :bnb => {:user_id => user.id }

      when 'Guest'
        can :read, Bnb
        can :create, Booking
        can :show, Booking
        can :my_bookings, Booking
        can :read, Photo
      else
        can :read, Bnb
        can :read, Photo
    end
  end

end
