class StaticPagesController < ApplicationController
  # encoding: utf-8


  caches_action :faq, :about, :terms_and_conditions, :privacy_policy, :ie_warning, :layout => false



  def home
    @photos = Photo.main_photo
  end


end
