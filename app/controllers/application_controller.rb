class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter proc { |controller| (controller.action_has_layout = false) if controller.request.xhr? }


  before_filter :correct_safari_and_ie_accept_headers
  after_filter :set_xhr_flash

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to(payment_plans_subscriptions_url) and return if subscription_expired?
    flash[:error] = exception.message
    redirect_to root_url
  end

  rescue_from ActionController::RoutingError, :with => :render_not_found


  private
  def after_sign_out_path_for(resource_or_scope)
    if current_user
      new_suggestion_url(:user_id => current_user.id)
    else
      root_url
    end
  end

  def subscription_expired?
    current_user.is?(:owner) && current_user.try(:active_subscription).has_expired? if current_user
  end

  def after_sign_in_path_for(resource_or_scope)
    if current_user.is?(:owner)
     show_bnb_url(current_user.bnb)
    else
      session.delete(:return_to) || root_url
    end
  end

  def correct_safari_and_ie_accept_headers
    ajax_request_types = ['text/javascript', 'application/json', 'text/xml']
    request.accepts.sort! { |x, y| ajax_request_types.include?(y.to_s) ? 1 : -1 } if request.xhr?
  end

  def set_xhr_flash
    flash.discard if request.xhr?
  end

  def set_return_url
    session[:return_to] = request.env['HTTP_REFERER'] unless is_same_controller_and_action?(request.env['HTTP_REFERER'], registration_page_url)
  end

  def is_same_controller_and_action?(url1, url2)
    hash_url1 = Rails.application.routes.recognize_path(url1)
    hash_url2 = Rails.application.routes.recognize_path(url2)

    [:controller, :action].each do |key|
      return false if hash_url1[key] != hash_url2[key]
    end
     true
  end

  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

  def render_not_found
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end


end
