class LineItemsController < ApplicationController
  before_filter :get_booking

  def create
    @line_item = @booking.line_items.build
    @line_item.description = 'describe charge'
    @line_item.value = 0
    if @line_item.save
      respond_to do |format|
        format.js { @line_item}
        format.json { render json: @line_item}
      end
    end
  end

  def update
    if @booking.line_items.find(params[:id]).update_attributes(params[:line_item])
      respond_to do |format|
        format.json { render json: {:total_price => @booking.total_price } }
      end
    end
  end

  def destroy
    @line_item = @booking.line_items.find(params[:id])
    @booking.line_items.destroy(@line_item)
    respond_to do |format|
      format.js { @line_item }
      format.json { render json: @line_item }
    end
  end

  def get_booking
    @booking = Booking.find(params[:booking_id])
  end

end
