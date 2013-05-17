module BookingsHelper

  def display_checkin_or_checkout(booking)
     case booking.status
       when :checked_in
        html = (link_to 'Check out', check_out_booking_path(booking), method: :put, class: "btn btn-warning")
      when :booked
        html = (link_to 'Check in', booking_path(@booking, {booking: { status: :checked_in}}), method: :put, remote: true, class: "btn btn-success")
       when :provisional
        html =(link_to 'Confirm', booking_path(@booking , { booking: { status: :booked}}), method: :put, remote: true, class: "btn btn-info")
      end
  end

  def display_status_label(status)
    case status
      when :checked_in
        content_tag(:span, status.capitalize, class: "label label-success")
      when :booked
        content_tag(:span, status.capitalize, class: "label label-info")
      when :provisional
        content_tag(:span, status.capitalize, class: "label label-important")
      when :closed
        content_tag(:span, status.capitalize, class: "label label-inverse")
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
