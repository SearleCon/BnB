
module PersistenceExtensions

  def created?
    created_at == updated_at && changes_persisted?
  end

  def updated?
   return false if new_record?
   updated_at > created_at && changes_persisted?
  end

  protected
  def changes_persisted?
    previous_changes.any? && persisted?
  end
end


ActiveRecord::Base.send(:include, PersistenceExtensions)
