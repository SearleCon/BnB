class LineItemsController < ApplicationController
   respond_to :js, only: [:create, :destroy]
   respond_to :json, only: :update
   before_filter :get_booking, only: :create
   before_filter :get_line_item, only: [:update, :destroy]


  def create
    @line_item = @booking.line_items.create(description: 'describe charge', value: 0)
    respond_with(@line_item)
  end

  def update
    @line_item.update_attributes(params[:line_item])
    respond_with_bip(@line_item)
  end

  def destroy
    @line_item.destroy
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
