class ProcessImageJob < Struct.new(:id, :key)
  def perform
    Photo.unscoped do
      photo = Photo.find(id)
      photo.key = key
      photo.save_and_process_image(:now => true)
    end
  end
end