require 'spec_helper'

describe BookingsController do
  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

 describe 'GET #show' do
   let(:room) { FactoryGirl.create(:room) }
   let!(:booking){ FactoryGirl.create(:booking, rooms: [room])}

    it 'assigns the requested booking' do
      xhr  :get, :show, id: booking
      expect(assigns(:booking)).to eq booking
    end

    it 'renders the show template' do
      xhr :get, :show, id: booking
      expect(response).to be_success
    end
 end

 describe 'GET #edit' do
    let(:room) { FactoryGirl.create(:room) }
    let!(:booking){ FactoryGirl.create(:booking, rooms: [room])}

    it 'assigns the requested booking' do
      get :edit, id: booking
      expect(assigns(:booking)).to eq booking
    end

    it 'renders the edit template' do
      get :edit, id: booking
      expect(response).to render_template :edit
    end
 end

 describe 'GET #new' do
    let!(:bnb) { FactoryGirl.create(:bnb) }

    it 'makes a new instance of booking' do
      get :new, bnb_id: bnb
      expect(assigns(:booking)).to be_a_new(Booking)
    end

    it 'makes a new instance of booking with a guest' do
      get :new, bnb_id: bnb
      expect(assigns(:booking).guest).to_not be_nil
    end

    it 'makes a new instance of booking with a guest' do
      get :new, bnb_id: bnb, start_at: Date.current
      expect(assigns(:booking).event).to_not be_nil
    end

    it 'renders the new template' do
      get :new, bnb_id: bnb
      expect(response).to render_template :new
    end
 end

 describe 'POST #create' do

   let(:bnb) { FactoryGirl.create(:bnb) }
   let(:room) { FactoryGirl.create(:room) }
   let(:rate) { FactoryGirl.create(:rate) }


   context 'valid attributes' do
     let!(:booking_attributes) { FactoryGirl.attributes_for(:booking, rate_id: rate ).merge( {event_attributes:  FactoryGirl.attributes_for(:event), guest_attributes: FactoryGirl.attributes_for(:guest)})   }

     it 'creates a booking' do
       expect {post :create, bnb_id: bnb.id, booking: booking_attributes,  room_ids: [room.id]}.to change(Booking, :count).by(1)
     end

     it 'redirects to the bnb bookings page' do
        post :create, bnb_id: bnb.id, booking: booking_attributes,  room_ids: [room.id]
        expect(response).to redirect_to bnb_bookings_url(bnb)
     end
   end

   context 'invalid attributes' do
     let!(:booking_attributes) { FactoryGirl.attributes_for(:booking).merge( {event_attributes:  FactoryGirl.attributes_for(:event), guest_attributes: FactoryGirl.attributes_for(:guest)})   }

     it 'does not create a booking' do
       expect {post :create, bnb_id: bnb.id, booking: booking_attributes,  room_ids: [room.id]}.to_not change(Booking, :count).by(1)
     end

     it 're renders the new template' do
       post :create, bnb_id: bnb.id, booking: booking_attributes,  room_ids: [room.id]
       expect(response).to render_template :new
     end
   end

 end

 describe 'PUT #update' do
   let(:room) { FactoryGirl.create(:room) }
   let!(:booking){ FactoryGirl.create(:booking, rooms: [room])}

   it 'locates the requested booking' do
     put :update, id: booking, booking: FactoryGirl.attributes_for(:booking)
     expect(assigns(:booking)).to eq booking
   end

   context 'valid attributes' do
     it 'changes booking attributes' do
       put :update, id: booking, booking: FactoryGirl.attributes_for(:booking, online: true)
       booking.reload
       expect(booking.online).to be_true
     end

     it 'redirects to the calendar page' do
       put :update, id: booking, booking: FactoryGirl.attributes_for(:booking, online: true)
       expect(response).to redirect_to(bnb_bookings_url(booking.bnb))
     end
   end

   context 'invalid attributes' do
     it 'does not change the bookings attributes' do
       put :update, id: booking, booking: FactoryGirl.attributes_for(:booking, rate_id: nil, online: true)
       booking.reload
       expect(booking.online).to be_false
     end

     it 're renders the edit template' do
       put :update, id: booking, booking: FactoryGirl.attributes_for(:booking, rate_id: nil, online: true)
       expect(response).to render_template :edit
     end
   end

 end

 describe 'PUT #check_in' do
   let(:room) { FactoryGirl.create(:room) }
   let!(:booking){ FactoryGirl.create(:booking, rooms: [room])}

   it 'locates the requested booking' do
     xhr :put, :check_in, id: booking
     expect(assigns(:booking)).to eq booking
   end

   it 'changes the status to checked in' do
     xhr :put, :check_in, id: booking
     expect(assigns(:booking).status).to eq :checked_in
   end

   it 'responds with http success' do
     xhr :put, :check_in, id: booking
     expect(response).to be_success
   end

 end

  describe 'PUT #check_out' do
    let(:room) { FactoryGirl.create(:room) }
    let!(:booking){ FactoryGirl.create(:booking, rooms: [room])}

    it 'locates the requested booking' do
      put :check_out, id: booking
      expect(assigns(:booking)).to eq booking
    end

    it 'generates the line items for the booking' do
      put :check_out, id: booking
      expect(assigns(:booking)).to have_at_least(1).line_items
    end

    it 'redirects to the invoice page' do
      put :check_out, id: booking
      expect(response).to redirect_to(show_invoice_booking_url(booking))
    end
  end

end
