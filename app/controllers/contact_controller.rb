class ContactController < ApplicationController
  def new
    @message = Message.new
    session[:last_page] = request.env['HTTP_REFERER']
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      BnbNotifier.delay.enquiry(@message)
      redirect_to root_url, notice: 'Email has been sent'
    else
      flash[:alert] = "Please fill all fields."
      render :new
    end
  end
end
