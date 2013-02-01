class UserMailer < ActionMailer::Base
  default from: "BnBeezy@example.com"

  def welcome(user)
    @user = user
    mail to: @user.email, subject: "Welcome"
  end

  def booking_made(booking)
    @booking = booking
    @user = User.find(@booking.user_id)
    mail to: user.email, subject: "Booking notification"
  end

  def notify_bnb(booking)
    @booking = booking
    mail to: @booking.bnb.email, subject: "Notice of online booking - #{@booking.guest.name} #{@booking.id}"
  end

  def confirmation_received(booking)
      @booking = booking
      @user = User.find(@booking.user_id)
      mail to: @user.email, subject: "Booking has been confirmed"
  end

end
