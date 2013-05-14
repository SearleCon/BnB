class ContactController < ApplicationController
  before_filter :new_resource

  def new
  end

  def create
    if @message.valid?
      BnbNotifier.delay.enquiry(@message)
      redirect_to root_url, notice: 'Thank you for contacting us. We will get back to you as soon as we can.'
    else
      render :new
    end
  end

  private
  def new_resource
    @message = Message.new(params[:message])
  end
end
