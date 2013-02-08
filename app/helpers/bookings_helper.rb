module BookingsHelper

  def display_checkin_or_checkout(booking)
     case booking.status
       when :checked_in
        html = (link_to 'Check out', check_out_bnb_booking_path(booking.bnb, booking), method: :put, class: "btn btn-primary")
      when :booked
        html = (link_to 'Check in', check_in_bnb_booking_path(booking.bnb,booking), method: :put, remote: true, class: "btn btn-success")
       when :provisional
         html =(link_to 'Confirm', confirm_bnb_booking_path(booking.bnb, booking), method: :put, remote: true, class: "btn btn-danger")
      end
  end
end
