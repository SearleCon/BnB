class RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper

  before_filter :set_return_url, only: :new

  def new
    @user = User.new { |user| user.roles = params[:user_role] }
  end

  def create
    super
    UserMailer.delay.welcome(@user) unless @user.invalid?
  end

  protected
  def after_sign_up_path_for(resource)
    if resource.is_owner? then
      startpage_url
    else
      session.delete(:return_to) || root_url
    end
  end
end
