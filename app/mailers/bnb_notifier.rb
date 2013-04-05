class BnbNotifier < ActionMailer::Base
  default from: "donotreply@bnbeezy.com"

  def enquiry(message)
    @message = message
    mail to: 'support@searleconsulting.co.za', subject: message.subject
  end

end
