class SessionsController < Devise::SessionsController

  # GET /resource/sign_in
  def new
    session[:last_page] = request.referrer
    super
  end

end