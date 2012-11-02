class StaticPagesController < ApplicationController

  caches_page :about, :contact, :terms_and_conditions, :privacy_policy

  def home
      @photos = Photo.find_all_by_main(true)
  end

  def help
  end
  
  def about
  end
  
  def contact
  end

  def terms_and_conditions

  end

  def privacy_policy

  end

  def startpage

  end

end
