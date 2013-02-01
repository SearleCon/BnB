class BnbNotifier < ActionMailer::Base
  default from: "BnBeezy"

  def enquiry(message)
    @message = message
    mail to: 'support@searleconsulting.co.za', subject: message.subject
  end

end
