class ContactController < ApplicationController
  def new
    if params[:bnb_id]
     @bnb = Bnb.find(params[:bnb_id])
     email = @bnb.email
    else
     email = "support@searleconsulting.co.za"
    end

    @message = Message.new
    @message.receiver = email
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
