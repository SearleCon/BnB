class SessionsController < Devise::SessionsController
  skip_before_filter :subscription_required, :only => :destroy

end