class BnbNotifier < ActionMailer::Base
  default from: "Your business"

  def enquiry(message)
    @message = message
    mail to: 'support@searleconsulting.co.za', subject: message.subject
  end

end
