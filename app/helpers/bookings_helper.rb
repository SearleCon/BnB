module BookingsHelper

  def display_checkin_or_checkout(booking)
     case booking.status
       when :checked_in
        html = (link_to 'Check out', check_out_bnb_booking_path(booking.bnb, booking), method: :put, class: "btn btn-warning")
      when :booked
        html = (link_to 'Check in', check_in_bnb_booking_path(booking.bnb,booking), method: :put, remote: true, class: "btn btn-success")
       when :provisional
         html =(link_to 'Confirm', confirm_bnb_booking_path(booking.bnb, booking), method: :put, remote: true, class: "btn btn-info")
      end
  end

  def edit_or_create_url(booking)
      bnb = booking.bnb
      if booking.new_record?
        url = bnb_bookings_path(bnb)
      else
        url = edit_bnb_booking_path(bnb)
      end
  end
end
