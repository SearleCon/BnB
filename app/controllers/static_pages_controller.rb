class StaticPagesController < ApplicationController
  # encoding: utf-8

  caches_action :faq, :about, :terms_and_conditions, :privacy_policy, :ie_warning, :layout => false

  caches_action :home, :cache_path => proc {|c|
    photo = Photo.main_photo.order('created_at DESC').limit(1).first
    unless photo.nil?
      c.params.merge!(:tag => photo.created_at.to_i )
    end
  }, :layout => false

  def home
    @photos = Photo.main_photo
  end
end
