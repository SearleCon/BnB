def helper
  Helper.instance
end

class Helper
  include Singleton
  include ActionView::Helpers::NumberHelper
  include Rails.application.routes.url_helpers
end