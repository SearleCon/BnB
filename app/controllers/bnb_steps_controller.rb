class BnbStepsController < ApplicationController
  include Wicked::Wizard
  steps :contact_details, :social_media

  def show
    @bnb = Bnb.find(params[:bnb_id])
    render_wizard
  end

  def update
    @bnb = Bnb.find(params[:bnb_id])
    @bnb.attributes = params[:bnb]
    render_wizard @bnb
  end

  private

  def redirect_to_finish_wizard
    redirect_to root_url
  end
end

