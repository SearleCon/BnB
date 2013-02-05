class SessionsController < Devise::SessionsController

  def new
    session[:return_to] = request.env['HTTP_REFERER']
    super
  end
end