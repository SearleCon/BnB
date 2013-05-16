class SessionsController < Devise::SessionsController
  include ApplicationHelper

  skip_before_filter :renew_subscription

  before_filter :set_return_url, only: :new

  def new
    super
  end
end