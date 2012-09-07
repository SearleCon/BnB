module BookingsHelper

  def display_checkin_or_checkout(booking)
     case booking.status
       when :checked_in
        html = (link_to 'Check out', check_out_booking_path(booking), method: :put, class: "btn btn-primary")
      when :booked
        html = (link_to 'Check in', check_in_booking_path(booking), method: :put, class: "btn btn-primary")
       when :provisional
         html =(link_to 'Confirm', confirm_booking_path(booking), method: :put, class: "btn btn-primary")
      end
  end
end
