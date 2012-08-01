class StaticPagesController < ApplicationController
  def home
    @bnb = Bnb.find_by_user_id(current_user)
    unless @bnb.nil?
     redirect_to bnb_path(@bnb)
    end
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
end
