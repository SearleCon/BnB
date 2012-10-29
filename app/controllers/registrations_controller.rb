class RegistrationsController < Devise::RegistrationsController
  def new
    @role = Role.find_by_description(params[:user_role])
    @user = User.new
    @user.role_id = @role.id
  end
end
