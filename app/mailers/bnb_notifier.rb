class BnbNotifier < ActionMailer::Base
  default from: "Your business"

  def enquiry(message)
    @message = message
    mail to: message.receiver, subject: message.subject
  end

end
