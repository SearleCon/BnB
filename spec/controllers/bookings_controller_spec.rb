require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe BookingsController do

  # This should return the minimal set of attributes required to create a valid
  # Booking. As you add validations to Booking, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BookingsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all bookings as @bookings" do
      booking = Booking.create! valid_attributes
      get :index, {}, valid_session
      assigns(:bookings).should eq([booking])
    end
  end

  describe "GET show" do
    it "assigns the requested booking as @booking" do
      booking = Booking.create! valid_attributes
      get :show, {:id => booking.to_param}, valid_session
      assigns(:booking).should eq(booking)
    end
  end

  describe "GET new" do
    it "assigns a new booking as @booking" do
      get :new, {}, valid_session
      assigns(:booking).should be_a_new(Booking)
    end
  end

  describe "GET edit" do
    it "assigns the requested booking as @booking" do
      booking = Booking.create! valid_attributes
      get :edit, {:id => booking.to_param}, valid_session
      assigns(:booking).should eq(booking)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Booking" do
        expect {
          post :create, {:booking => valid_attributes}, valid_session
        }.to change(Booking, :count).by(1)
      end

      it "assigns a newly created booking as @booking" do
        post :create, {:booking => valid_attributes}, valid_session
        assigns(:booking).should be_a(Booking)
        assigns(:booking).should be_persisted
      end

      it "redirects to the created booking" do
        post :create, {:booking => valid_attributes}, valid_session
        response.should redirect_to(Booking.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved booking as @booking" do
        # Trigger the behavior that occurs when invalid params are submitted
        Booking.any_instance.stub(:save).and_return(false)
        post :create, {:booking => {}}, valid_session
        assigns(:booking).should be_a_new(Booking)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Booking.any_instance.stub(:save).and_return(false)
        post :create, {:booking => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested booking" do
        booking = Booking.create! valid_attributes
        # Assuming there are no other bookings in the database, this
        # specifies that the Booking created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Booking.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => booking.to_param, :booking => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested booking as @booking" do
        booking = Booking.create! valid_attributes
        put :update, {:id => booking.to_param, :booking => valid_attributes}, valid_session
        assigns(:booking).should eq(booking)
      end

      it "redirects to the booking" do
        booking = Booking.create! valid_attributes
        put :update, {:id => booking.to_param, :booking => valid_attributes}, valid_session
        response.should redirect_to(booking)
      end
    end

    describe "with invalid params" do
      it "assigns the booking as @booking" do
        booking = Booking.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Booking.any_instance.stub(:save).and_return(false)
        put :update, {:id => booking.to_param, :booking => {}}, valid_session
        assigns(:booking).should eq(booking)
      end

      it "re-renders the 'edit' template" do
        booking = Booking.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Booking.any_instance.stub(:save).and_return(false)
        put :update, {:id => booking.to_param, :booking => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested booking" do
      booking = Booking.create! valid_attributes
      expect {
        delete :destroy, {:id => booking.to_param}, valid_session
      }.to change(Booking, :count).by(-1)
    end

    it "redirects to the bookings list" do
      booking = Booking.create! valid_attributes
      delete :destroy, {:id => booking.to_param}, valid_session
      response.should redirect_to(bookings_url)
    end
  end

end
