class StaticPagesController < ApplicationController
  def home
   @bnb = Bnb.last
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
end
