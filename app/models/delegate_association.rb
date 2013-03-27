module DelegateAssociation
  extend ActiveSupport::Concern

  included do
    associations = self.reflect_on_all_associations.select(&:collection?).map(&:name)

    associations.each do |assoc|

      plural_association_name = assoc.to_s
      singular_association_name = plural_association_name.singularize

      define_method("build_#{singular_association_name}") do |*args, &block|
        send(plural_association_name).build(*args, &block)
      end

      define_method("create_#{singular_association_name}") do |*args, &block|
        send(plural_association_name).create(*args, &block)
      end

      define_method("add_#{singular_association_name}") do |object|
        send(plural_association_name) << object
      end

      define_method("remove_#{singular_association_name}") do |object|
        send(plural_association_name).delete(object)
      end

      define_method("clear_#{plural_association_name}") do
        send(plural_association_name).clear
      end

      define_method("number_of_#{plural_association_name}") do
        send(plural_association_name).length
      end

      define_method("#{singular_association_name}_count") do |*args|
        send(plural_association_name).count(*args)
      end

      define_method("any_#{plural_association_name}?") do
        send(plural_association_name).any?
      end

      define_method("#{plural_association_name}_empty?") do
        send(plural_association_name).empty?
      end

      define_method("find_#{plural_association_name}") do |*args|
        send(plural_association_name).find(*args)
      end
    end
  end

end