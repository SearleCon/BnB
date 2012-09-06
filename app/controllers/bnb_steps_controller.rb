class BnbStepsController < ApplicationController
  include Wicked::Wizard
  steps :bnb_details, :contact_details, :social_media

  def show
    @bnb = Bnb.find(params[:bnb_id])
    render_wizard
  end

  def update
    @bnb = Bnb.find(params[:bnb_id])
    build_rooms(params[:bnb][:number_of_rooms].to_i) if params[:bnb][:number_of_rooms]
    params[:bnb][:status] = step.to_s
    params[:bnb][:status] = 'active' if step == steps.last
    @bnb.update_attributes(params[:bnb])
    render_wizard @bnb
  end

  private
  def finish_wizard_path
    show_bnb_url(@bnb)
  end

  def build_rooms (number_of_rooms)
    unless number_of_rooms.nil? or number_of_rooms < 1
      room_number = 1
      Room.transaction do
       number_of_rooms.times do
          @bnb.rooms.create(:description => 'Room'.concat(room_number.to_s), :room_number => room_number, :extras => 'none', :rates => 0, :en_suite => false)
          room_number = room_number + 1
        end
      end
    end
  end


end

