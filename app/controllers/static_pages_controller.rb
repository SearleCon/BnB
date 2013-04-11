class StaticPagesController < ApplicationController
  # encoding: utf-8
  before_filter :generate_cache_key

  def home
    #@photos = Photo.includes(:bnb).processed.main_photo
    @photos = Photo.where(bnb_id: Bnb.approved).processed.main_photo
  end


  private
  def generate_cache_key
    page_name = action_name.dup
    @cache_key = page_name.concat("-#{AppName::REVISION}")
  end

end
