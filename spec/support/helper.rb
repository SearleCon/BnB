def helper
  Helper.instance
end

def build_attributes(*args)
  build_object = FactoryGirl.build(*args)
  build_object.attributes.slice(*build_object.class.accessible_attributes).symbolize_keys
end

class Helper
  include Singleton
  include ActionView::Helpers::NumberHelper
  include Rails.application.routes.url_helpers


end