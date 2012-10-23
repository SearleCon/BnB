class UserMailer < ActionMailer::Base
  default from: "Bnbeezy@example.com"

  def welcome(user)
    @user = user

    mail to: @user.email, subject: "Welcome"

  end

  def booking_made(user, booking)
    @booking = booking

    mail to: user.email, subject: "Booking notification"
  end

  def notify_bnb(booking)
    @booking = booking
    subject_Text = "Notice of online booking - #{@booking.guest.name} #{@booking.id}"

    mail to: @booking.bnb.email, subject: subject_Text
  end

  def confirmation_received(booking)
      @booking = booking
      @user = User.find(@booking.user_id)

      mail to: @user.email, subject: "Booking has been confirmed"
  end

end
