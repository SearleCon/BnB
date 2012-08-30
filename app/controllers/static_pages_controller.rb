class StaticPagesController < ApplicationController
  def home

    if signed_in?
      @bnb = Bnb.find_by_user_id(current_user)
      unless @bnb.nil?
       redirect_to bookings_url
      end
    else
      @photos = Photo.all(limit: 5)
    end

  end

  def help
  end
  
  def about
  end
  
  def contact
  end
end
