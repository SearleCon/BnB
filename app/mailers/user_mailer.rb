class UserMailer < ActionMailer::Base


  def welcome(user)
    @user = user
    mail from: 'registrations@bnbeezy.com', to: @user.email, subject: "Welcome"
  end

  def booking_made(booking)
    @booking = booking
    @user = User.find(@booking.user_id)
    mail from: "donotreply@bnbeezy.com", to: @user.email, subject: "Booking notification"
  end

  def notify_bnb(booking)
    @booking = booking
    @user = User.find(booking.bnb.user_id)
    mail from: "donotreply@bnbeezy.com" , to: @user.email, subject: "Notice of online booking - #{@booking.guest.name} #{@booking.id}"
  end

  def confirmation_received(booking)
      @booking = booking
      @user = User.find(@booking.user_id)
      mail from: "donotreply@bnbeezy.com", to: @user.email, subject: "Booking has been confirmed"
  end
end
