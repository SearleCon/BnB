module ApplicationHelper
  def full_title(page_title)
    base_title = "BnBeezy"
    if page_title.empty?
       base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def correct_root_for_user
    (current_user && current_user.is?(:owner)) ? show_bnb_path(current_user.bnb) : root_path
  end

  def fetch_menu_for_role
   if current_user
    case current_user.roles.first
      when :admin
        'layouts/admin_menu_items'
      when :owner
        'layouts/owner_menu_items'
      else
        'layouts/guest_menu_items'
    end
   end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

  def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end

  def sort_countries_for_carmen(countries)
    sorted_countries = countries.map{|c| c.name}.sort
  end

  def display_icon(icon)
    raw('<i class=' + icon + '></i>')
  end

  def set_return_url
    session[:return_to] = request.env['HTTP_REFERER'] unless is_same_controller_and_action?(request.env['HTTP_REFERER'], registration_page_url) || is_same_controller_and_action?(request.env['HTTP_REFERER'], new_suggestion_url)
  end


  def is_same_controller_and_action?(url1, url2)
    hash_url1 = Rails.application.routes.recognize_path(url1)
    hash_url2 = Rails.application.routes.recognize_path(url2)

    [:controller, :action].each do |key|
      return false if hash_url1[key] != hash_url2[key]
    end
    true
  end
end
