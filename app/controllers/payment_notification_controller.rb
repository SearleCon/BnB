class PaymentNotificationController < ApplicationController
  protect_from_forgery :except => [:create]



  def create
    if valid_ipn?
      PaymentNotification.create!(:params => params, :user_id => params[:reference], :status => params[:payment_status], :transaction_id => params[:txn_id])
      render :nothing => true
    end
  end

  def valid_ipn?
   notification = PayPal::Recurring::Notification.new(params)
   notification.verified?
  end



end
