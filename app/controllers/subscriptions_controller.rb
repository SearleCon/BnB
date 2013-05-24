class SubscriptionsController < ApplicationController

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/new
  # GET /subscriptions/new.json
  def new
    @plan = Plan.find(params[:plan_id])
    @subscription = @plan.subscriptions.build
    if params[:PayerID]
      @subscription.paypal_customer_token = params[:PayerID]
      @subscription.paypal_payment_token = params[:token]
    end
  end


  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = current_user.subscriptions.build(params[:subscription])
    if @subscription.save_with_paypal_payment
      redirect_to @subscription
    else
      render :new
    end
    rescue PaypalError => error
      redirect_to root_url, alert: error.message
  end

  def payment_plans
    @plans = Plan.find_all_by_active(true)
  end

  def paypal_checkout
    plan = Plan.find(params[:plan_id])
    subscription = plan.subscriptions.new
    subscription.user_id = current_user.id
    redirect_to subscription.paypal.checkout_url(
                    return_url: new_subscription_url(plan_id: plan.id),
                    cancel_url: root_url, ipn_url: payment_notifications_url)
  end



end
