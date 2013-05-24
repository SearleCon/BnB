module BnbsHelper
  def display_action_links_for_user
    if user_signed_in?
      content_tag(:p, align: "center") { link_to "Book Now", new_guest_bnb_booking_path(@bnb), class: "btn-large btn-primary" } if current_user.is_guest?
    else
      content_tag(:div) do
         concat(content_tag(:p, align: "center") { link_to "Sign in to book", new_user_session_path, class: "btn btn-primary" })
         concat(content_tag(:p, align: "center") { link_to "No Account? Register here. It's Free!", register_path("guest"), class: "btn btn-primary" })
      end.html_safe
    end
  end

  def display_main_photo(photo)
    if photo
      content_tag(:a, href: photo.image_url, class: "thumbnail", rel: "lazybox") do
        image_tag photo.image_url
      end
    else
      placeholdit_image_tag "300", text: "No photos uploaded!"
    end
  end

  def show_rating_stars(number_of_stars, *args)
    options = args.extract_options!
    number_of_stars.times.collect do
      if options[:invert]
        content_tag :i, nil, class: "icon-star icon-black"
      else
        content_tag :i, nil, class: "icon-star icon-white"
      end
    end.join().html_safe
  end


  def display_support_photos(photos)
    if photos
      photos.collect do |photo|
        content_tag(:li, class: "span3") do
          content_tag(:div, class: "thumbnail") do
            content_tag(:a, href: photo.image_url, class: "thumbnail", rel: "lazybox") do
              image_tag photo.image_url(:thumb)
            end
          end
        end
      end.join().html_safe
    else
      4.times.collect do
        content_tag(:li, class: "span3") do
          content_tag(:div, class: "thumbnail") do
            placeholdit_image_tag "300", text: "No photos uploaded!"
          end
        end
      end.join().html_safe
    end
  end
end
