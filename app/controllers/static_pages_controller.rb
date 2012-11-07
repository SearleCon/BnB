class StaticPagesController < ApplicationController
  # encoding: utf-8

  caches_page :about, :contact, :terms_and_conditions, :privacy_policy, :faq

  def home
      @photos = Photo.find_all_by_main(true)
  end

  def faq

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
