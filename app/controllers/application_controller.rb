require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery

  before_filter :require_layout, :correct_xhr_headers, :renew_subscription
  after_filter :set_xhr_flash

  private
  # Devise
  def after_sign_in_path_for(resource_or_scope)
    if current_user.is_owner?
      show_bnb_url(current_user.bnb)
    else
      session.delete(:return_to) || root_url
    end
  end


  def after_sign_out_path_for(resource_or_scope)
    current_user ? new_suggestion_url : root_url
  end

  #Subscriptions
  def renew_subscription
    if current_user && current_user.is_owner?
      redirect_to(payment_plans_subscriptions_url) if current_user.subscriptions.first.has_expired?
    end
  end


  #Ajax setup
  def require_layout
    action_has_layout = !request.xhr?
  end

  def correct_xhr_headers
    ajax_request_types = ['text/javascript', 'application/json', 'text/xml']
    request.accepts.sort! { |x, y| ajax_request_types.include?(y.to_s) ? 1 : -1 } if request.xhr?
  end

  def set_xhr_flash
    flash.discard if request.xhr?
  end
end
