class ProcessImageJob < Struct.new(:id, :key)
  def perform
    photo = Photo.find(id)
    photo.key = key
    photo.save_and_process_image(:now => true)
  end
end