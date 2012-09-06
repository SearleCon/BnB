class StaticPagesController < ApplicationController
  def home
      @photos = Photo.all(limit: 5)
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
end
