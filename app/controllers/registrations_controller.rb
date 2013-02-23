class RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper

  before_filter :set_return_url, :only => :new

  def new
    @user = User.new { |user| user.roles = params[:user_role] }
  end

  protected
  def after_sign_up_path_for(resource_or_scope)
     if current_user.is?(:owner)
       startpage_url
     else
       session.delete(:return_to) || root_url
     end
  end




end
