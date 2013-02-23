class SessionsController < Devise::SessionsController
  include ApplicationHelper

  before_filter :set_return_url, :only => :new

  def new
    super
  end
end