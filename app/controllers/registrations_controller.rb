class RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper

  skip_before_filter :renew_subscription

  before_filter :set_return_url, only: :new

  def new
    @user = User.new { |user| user.roles = params[:user_role] }
  end

  def create
    super
    UserMailer.delay.welcome(@user) unless @user.invalid?
  end

  def destroy
    if resource.is?(:owner) then
      (resource.bnb.destroy if resource.bnb)
    else
      Booking.destroy_all(user_id: resource)
    end
    super
  end

  protected
  def after_sign_up_path_for(resource_or_scope)
     if resource_or_scope.is?(:owner)
       startpage_url
     else
       session.delete(:return_to) || root_url
     end
  end
end
