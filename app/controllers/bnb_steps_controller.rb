class BnbStepsController < ApplicationController
  include Wicked::Wizard
  steps :bnb_details, :contact_details, :social_media
  before_filter :get_bnb
  before_filter :set_values, only: :update
  def show
    render_wizard
  end

  def update
    @bnb.status = last_step(step) ? 'active' : step.to_s
    @bnb.region = Search.new(params[:search]).region if params[:search]
    @bnb.save
    @step_text = last_step(step) ? 'Finish' : 'Continue'
    render_wizard @bnb
  end

  private
  def finish_wizard_path
    if @bnb.rooms.any?
     flash[:notice] = "Bnb was saved successfully."
     show_bnb_url(@bnb)
    else
     flash[:notice] = "Bnb details complete. Please add rooms now to complete your setup."
     bnb_rooms_url(@bnb)
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

