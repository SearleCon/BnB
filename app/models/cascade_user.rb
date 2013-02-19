module CascadeUser
  extend ActiveSupport::Concern

  included do
    after_save :cascade_user
  end

  def cascade_user
    booking = self
    booking.class.reflect_on_all_associations.collect(&:name).each do |assoc_name|

        associated_object = booking.try(:send, assoc_name)
        unless associated_object.nil?

          if associated_object.is_a? Array
            associated_object.each { |a| a.send(:user_id=, booking.send(:user_id)).save! unless a.send(:user_id) if a.has_attribute? :user_id }
          else
            if associated_object.has_attribute? :user_id
             associated_object.send(:user_id=, booking.send(:user_id))
             associated_object.save!
            end
          end
       end
    end
  end
end