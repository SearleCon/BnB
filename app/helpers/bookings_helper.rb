module BookingsHelper

  def display_checkin_or_checkout(booking)
    if booking.checked_in?
      html = (link_to content_tag('i', '', class: 'icon-remove').concat('Checkout'), check_out_booking_path(booking), method: :put)
    else
      html = (link_to content_tag('i', '', class: 'icon-ok').concat('Checkin'), check_in_booking_path(booking), method: :put)
    end
  end


end
