class RegistrationsController < Devise::RegistrationsController
  def new
    @role = Role.find_by_description(params[:user_role])
    @user = User.new
    @user.role_id = @role.id
  end

  protected
  def after_sign_up_path_for(resource_or_scope)
    startpage_url
  end

end
