class Ability
  include CanCan::Ability

  def initialize(user)

    if user.role.description == 'Owner'
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

      #Guest
      can :manage, Guest, :bnb => {:user_id => user.id}

      #Events
      can :manage, Event

      #LineItems
      can :manage, LineItem





    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
