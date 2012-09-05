class BnbNotifier < ActionMailer::Base
  default from: "from@example.com"

  def enquiry(message)
    @message = message
    mail to: message.receiver, subject: message.subject
  end

end
