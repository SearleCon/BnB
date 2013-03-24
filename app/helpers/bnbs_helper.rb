module BnbsHelper
  def display_action_links_for_user
    if user_signed_in? && current_user.is?(:guest) then
      content_tag(:p, :align => "center") do
        link_to "Book Now", new_bnb_booking_path(@bnb), :class => "btn btn-primary"
      end
    elsif !user_signed_in?
      content_tag(:div) do
        @links =
            content_tag(:p, :align => "center") do
              link_to "Sign in to book", new_user_session_path, :class => "btn btn-primary"
            end
        @links << content_tag(:p, :align => "center") do
          link_to "No Account? Register here. It's Free!", register_path("guest"), class: "btn btn-primary"
        end
      end
    end
  end
end
