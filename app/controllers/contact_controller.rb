class ContactController < ApplicationController
  def new
    @message = Message.new
    session[:last_page] = request.env['HTTP_REFERER']
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      BnbNotifier.delay.enquiry(@message)
      url = session[:last_page] ? session[:last_page] : root_url
      redirect_to url, notice: 'your email was sent'
    else
      flash.now.alert = "Please fill all fields."
      render :new
    end
  end
end
