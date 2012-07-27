class BnbStepsController < ApplicationController
  include Wicked::Wizard
  steps :bnb_details,:contact_details, :social_media

  def show
    @bnb = Bnb.find(params[:bnb_id])
    render_wizard
  end

  def update
    @bnb = Bnb.find(params[:bnb_id])
    params[:bnb][:status] = step.to_s
    params[:bnb][:status] = 'active' if step == steps.last
    @bnb.update_attributes(params[:bnb])
    render_wizard @bnb
  end

  private
  def redirect_to_finish_wizard
    redirect_to root_url
  end
end

