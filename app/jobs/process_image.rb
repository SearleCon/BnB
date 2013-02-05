class ProcessImageJob < Struct.new(:attributes)
  def perform
    photo = Photo.new.tap{|photo| photo.assign_attributes(attributes, :without_protection => true)}
    photo.save_and_process_image(:now => true)
  end
end