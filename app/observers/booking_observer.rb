class BookingObserver < ActiveRecord::Observer


 def before_create(booking)
   booking.status = :booked unless booking.online
   booking.event.name = "#{booking.guest.name} (#{booking.guest.contact_number} #{booking.guest.email})"
   booking.event.color = get_event_colour(booking.status)
 end

 def after_create(booking)
   if booking.online?
     UserMailer.delay.booking_made(booking)
     UserMailer.delay.notify_bnb(booking)
   end
 end

 def before_update(booking)
   booking.event.color = get_event_colour(booking.status)
 end

 def after_update(booking)
   if booking.booked? && booking.online?
     UserMailer.delay.confirmation_received(booking)
   end
 end


private
def get_event_colour(status_for_colour)
  case status_for_colour
    when :booked
      'blue'
    when :checked_in
      'green'
    when :closed
      'orange'
    else
      'red'
  end
end


end