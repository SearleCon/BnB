class BookingObserver < ActiveRecord::Observer

 def after_initialize(booking)
   unless booking.event
     booking.build_event
   end
   unless booking.guest
     booking.build_guest
   end
 end


 def before_create(booking)
   booking.event.name = "#{booking.guest.name} #{booking.guest.contact_number} #{booking.guest.email}"
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
      'green'
    when :checked_in
      'red'
    when :closed
      'orange'
    else
      'blue'
  end
end


end