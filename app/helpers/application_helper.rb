module ApplicationHelper
  def full_title(page_title)
    base_title = "Searle Consulting - Rails App Test Site"
    if page_title.empty?
      return base_title
    else
      "#{base_title} | #{page_title}"
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

end
