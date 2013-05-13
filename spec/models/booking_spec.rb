require 'spec_helper'

#TODO Constant and Delegate tests
describe Booking do

  #TODO Figure out has_many in FactoryGirl
  it 'has a valid factory' do
    room = FactoryGirl.create(:room)
    expect(FactoryGirl.create(:booking, rooms: [room])).to be_valid
  end

  #Relationships
  it { should belong_to(:bnb) }
  it { should belong_to(:guest) }
  it { should belong_to(:rate) }
  it { should have_many(:line_items).dependent(:delete_all) }
  it { should have_and_belong_to_many(:rooms) }
  it { should have_one(:event).dependent(:delete) }

  it { should accept_nested_attributes_for(:event) }
  it { should accept_nested_attributes_for(:guest) }

  #Validations
  describe 'Validations' do
    it { should validate_presence_of(:rooms) }
    it { should validate_presence_of(:guest) }
  end

  #CallBacks
  describe 'Callbacks' do
    describe 'before_save' do
      it { described_class._save_callbacks.select{|cb| cb.kind.eql?(:before)}.collect(&:filter).should include(:set_event_details) }

      describe '#set_event_details' do
        context 'name' do
          it 'should set event name to guest name, contact number and email' do
            room = FactoryGirl.create(:room)
            booking = FactoryGirl.create(:booking, rooms: [room])
            booking.send(:set_event_details)
            expect(booking.event.name).to include booking.guest[:name]
            expect(booking.event.name).to include booking.guest[:contact_number]
            expect(booking.event.name).to include booking.guest[:email]
          end
        end
        context 'color' do

          before(:each) do
            @room = FactoryGirl.create(:room)

          end

          it 'should be red for provisional' do
            booking = FactoryGirl.create(:booking, status: :provisional ,rooms: [@room])
            booking.send(:set_event_details)
            expect(booking.event_color).to eq 'red'
          end

          it 'should be blue for booked' do
            booking = FactoryGirl.create(:booking, status: :booked ,rooms: [@room])
            booking.send(:set_event_details)
            expect(booking.event_color).to eq 'blue'
          end

          it 'should be green for checked_in' do
            booking = FactoryGirl.create(:booking, status: :checked_in ,rooms: [@room])
            booking.send(:set_event_details)
            expect(booking.event_color).to eq 'green'
          end

          it 'should be orange for closed' do
            booking = FactoryGirl.create(:booking, status: :closed ,rooms: [@room])
            booking.send(:set_event_details)
            expect(booking.event_color).to eq 'orange'
          end
        end
      end
    end
  end

  #Scopes
  describe 'Scopes' do
    before(:each) do
      @room = FactoryGirl.create(:room)
    end

    describe 'defaults to active do' do

      context 'build the model' do
        it 'should be active when the model is built' do
         booking = FactoryGirl.build(:booking)
         expect(booking.active).to be_true
        end
      end

      context 'active bookings' do
        it 'should return active bookings' do
         booking = FactoryGirl.create(:booking, active: true, rooms: [@room])
         expect(Booking.all).to eq [booking]
        end
      end

      context 'no active bookings' do
        it 'should return active bookings' do
         booking = FactoryGirl.create(:booking, active: false , rooms: [@room])
         expect(Booking.all).to_not eq [booking]
        end
      end
    end

    describe 'inactive' do
      context 'inactive bookings' do
        it 'should return inactive bookings' do
          booking = FactoryGirl.create(:booking, active: false , rooms: [@room])
          expect(Booking.inactive).to eq [booking]
        end
      end

      context 'no inactive bookings' do
        it 'should return inactive bookings' do
          booking = FactoryGirl.create(:booking, active: true , rooms: [@room])
          expect(Booking.inactive).to_not eq [booking]
        end
      end
    end
  end

  #Instance Methods
  describe '#total_price' do
    it 'should return the sum of the line_items' do
       room = FactoryGirl.create(:room)
       line_item = FactoryGirl.create(:line_item)
       booking = FactoryGirl.create(:booking, rooms: [room], line_items: [line_item])
       expect(booking.total_price).to eq line_item.value
    end
  end



end
