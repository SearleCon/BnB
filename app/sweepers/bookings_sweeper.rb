class BookingsSweeper < ActionController::Caching::Sweeper
  observe Booking

  def after_create(booking)
    expire_cache_for(booking)
    expire_events_cache(booking)
  end

  def after_update(booking)
    expire_cache_for(booking)
    expire_events_cache(booking)
  end

  def after_destroy(booking)
    expire_cache_for(booking)
    expire_events_cache(booking)
  end

  private
  def expire_cache_for(booking)
    expire_action(booking_url(booking))
  end

  def expire_events_cache(booking)
    expire_action(events_url(tag: booking.bnb))
  end


end