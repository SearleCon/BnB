class LineItemsController < ApplicationController
   respond_to :js, only: [:create, :destroy]
   respond_to :json, only: :update
   before_filter :get_booking
   before_filter :get_line_item, :only => [:update, :destroy]


  def create
    @line_item = @booking.line_items.build(:description => 'describe charge', :value => 0)
    flash.now[:error] = "An error occurred. Line item could not be created." unless @line_item.save
    respond_with(@line_item)
  end

  def update
    @line_item.update_attributes(params[:line_item])
    respond_with_bip(@line_item)
  end

  def destroy
    @line_item.destroy
    flash.now[:error] = 'An error occurred. Line item could not be removed.' unless @line_item.destroyed?
    respond_with(@line_item)
  end


  private
  def get_booking
    @booking = Booking.find(params[:booking_id])
  end

  def get_line_item
    @line_item = LineItem.find(params[:id])
  end

end
