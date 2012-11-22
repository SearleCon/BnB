class RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new
    @user.roles = params[:user_role]
  end

  protected
  def after_sign_up_path_for(resource_or_scope)
    startpage_url
  end

end
