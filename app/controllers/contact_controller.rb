class ContactController < ApplicationController
  def new
    @bnb = Bnb.find(params[:bnb_id])
    @message = Message.new
    @message.receiver= @bnb.email
  end

  def create
    @message = Message.new(params[:message])

    if @message.valid?
      BnbNotifier.delay.enquiry(@message)
      redirect_to root_path
    else
      flash.now.alert = "Please fill all fields."
      render :new
    end
  end
end
