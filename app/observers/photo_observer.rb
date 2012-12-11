class PhotoObserver < ActiveRecord::Observer

  def before_create(photo)
    if photo.main?
      existing_main = Photo.find_by_bnb_id_and_main(photo.bnb_id, true)
      existing_main.toggle!(:main) unless existing_main.nil?
    end
  end
end
