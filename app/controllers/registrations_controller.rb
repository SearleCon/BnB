class RegistrationsController < Devise::RegistrationsController

  def new
    session[:return_to] = request.env['HTTP_REFERER']
    @user = User.new
    @user.roles = params[:user_role]
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
