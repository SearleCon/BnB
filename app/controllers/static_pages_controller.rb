class StaticPagesController < ApplicationController

  def home
      @photos = Photo.find_all_by_main(true)
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
end
