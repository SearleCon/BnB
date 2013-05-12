require 'spec_helper'

describe Room do

  it 'has a valid factory' do
    expect(FactoryGirl.create(:room)).to be_valid
  end

  #Relationships
  it { should belong_to(:bnb) }
  it { should have_and_belong_to_many(:bookings) }
  it { should have_many(:guests).through(:bookings) }

  #Validations
  describe 'Validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:rates) }
    it { should validate_presence_of(:room_number) }
    it { should validate_presence_of(:capacity) }

    it { should validate_numericality_of(:room_number) }
    it { should validate_numericality_of(:capacity) }
    it { should validate_numericality_of(:rates) }

    it { should allow_value("1").for(:rates) }
    it { should allow_value("0.99").for(:rates) }
    it { should allow_value("200.90").for(:rates) }
    it { should_not allow_value('test').for(:rates) }

    it { should ensure_length_of(:description).is_at_least(2) }
  end

  # Scopes
  describe 'Scopes' do
    describe '.unbooked_rooms' do
      before(:each) do
        @available = FactoryGirl.create(:room)
        @unavailable = FactoryGirl.create(:room)
        @booking = FactoryGirl.create(:booking, rooms: [@unavailable])
      end

      context 'rooms available' do
        it 'should return available room' do
          expect(Room.unbooked_rooms(Date.today, Date.tomorrow)).to eq [@available]
        end
      end

      context 'rooms unavailable' do
        it 'should not return unavailable room' do
          expect(Room.unbooked_rooms(Date.today, Date.tomorrow)).to_not eq [@unavailable]
        end
      end
    end
  end

  # Instance Methods
  describe 'Instance Methods' do
    describe '#room_info' do
      it 'should return a string containing description, rates and capacity' do
         room = FactoryGirl.create(:room, rates: 1, capacity: 1, description: 'test')
         expect(room.room_info).to eq 'test Capacity: 1 Rate: 1.0'
      end
    end
  end

end
