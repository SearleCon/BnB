class BnbStepsController < ApplicationController
  include Wicked::Wizard
  steps :bnb_details, :contact_details, :social_media
  before_filter :get_bnb
  before_filter :set_values, :only => :update
  def show
    render_wizard
  end

  def update
    @bnb.status = last_step(step) ? 'active' : step.to_s
    @bnb.region = Search.new(params[:search]).region if params[:search]
    build_default_rooms if @bnb.rooms.empty?
    @bnb.save
    @step_text = last_step(step) ? 'Finish' : 'Continue'
    render_wizard @bnb
  end

  private
  def finish_wizard_path
    show_bnb_url(@bnb)
  end

  def build_default_rooms
         room_number = 1
         @bnb.number_of_rooms.to_i.try(:times) do
            @bnb.rooms.build(:description => 'Room'.concat(room_number.to_s), :room_number => room_number, :extras => 'none', :rates => @bnb.standard_rate.to_i, :capacity => 2, :en_suite => false)
            room_number += 1
         end
  end



  def get_bnb
    @bnb = Bnb.find(params[:bnb_id])
  end

  def set_values
    @bnb.assign_attributes(params[:bnb])
  end


  def last_step(step)
     step == steps.last
  end
end

