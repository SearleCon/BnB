class BookingObserver < ActiveRecord::Observer


 def before_save(booking)
   if booking.new_record?
     booking.status = :booked unless booking.online
     booking.event.name = "#{booking.guest.name} (#{booking.guest.contact_number} #{booking.guest.email})"
   end
   booking.event.color = get_event_colour(booking.status)
 end



 def after_commit(booking)
   if persisted? && booking.online?
     if record_created?
         UserMailer.delay.booking_made(booking)
         UserMailer.delay.notify_bnb(booking)
     else
       UserMailer.delay.confirmation_received(booking) if booking.booked?
     end
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

def record_created?
  booking.created_at == booking.updated_at
end


end