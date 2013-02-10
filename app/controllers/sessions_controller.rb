class SessionsController < Devise::SessionsController

  before_filter :set_return_url, :only => :new

  def new
    super
  end
end