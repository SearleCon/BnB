class SetupWizardController < ApplicationController
  include Wicked::Wizard

  before_filter :get_bnb

  steps :bnb_details, :rates, :contact_details, :social_media

  def show
    render_wizard
  end

  def update
    @bnb.status = (step == steps.last) ? 'active' : step.to_s
    @bnb.update_attributes(params[:bnb])
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
end

