# == Schema Information
#
# Table name: events
#
#  id         :integer          primary key
#  name       :string(255)
#  start_at   :timestamp
#  end_at     :timestamp
#  created_at :timestamp        not null
#  updated_at :timestamp        not null
#  booking_id :integer
#  color      :string(255)      default("blue")
#

require 'spec_helper'

describe Event do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:event)).to be_valid
  end

  #Relationships
  it { should belong_to(:booking).touch(true) }

  #Callbacks
  describe 'Callbacks' do
    describe 'after_initialize' do
      it { described_class._initialize_callbacks.select{|cb| cb.kind.eql?(:after)}.collect(&:filter).should include(:default_values) }

      describe '#default_values' do
        it 'should set a default start and end date' do
          event = FactoryGirl.build(:event, start_at: nil, end_at: nil)
          event.send(:default_values)
          expect(event.start_at).to eq Time.zone.now.strftime('%A, %d %B %Y')
          expect(event.end_at).to eq (Time.zone.now + 1.days).strftime('%A, %d %B %Y')
        end
      end
    end
  end

  #Scopes
  describe 'Scopes' do
    describe 'by_bookings' do
      it 'should return events by bookings' do
        room = FactoryGirl.create(:room)
        event = FactoryGirl.create(:event)
        booking = FactoryGirl.create(:booking, event: event, rooms: [room])
        expect(Event.by_bookings(booking)).to eq [event]
      end
    end
  end

  #Instance Methods
  describe 'Instance Methods' do
    describe '#start_at' do
      it 'should format the start date' do
        event = FactoryGirl.create(:event, start_at: Time.zone.now)
        expect(event.start_at).to eq Time.zone.now.strftime('%A, %d %B %Y')
      end
    end

    describe '#end_at' do
      it 'should format the end date' do
        event = FactoryGirl.create(:event, end_at: Time.zone.now)
        expect(event.end_at).to eq Time.zone.now.strftime('%A, %d %B %Y')
      end
    end

    describe '#as_json' do
      it 'should return custom json values' do
        event = FactoryGirl.create(:event, start_at: Time.zone.now, end_at: Time.zone.now + 1.day)
        room = FactoryGirl.create(:room)
        booking = FactoryGirl.create(:booking, rooms: [room], event: event)
        json = event.as_json
        expect(json[:id]).to eq event.id
        expect(json[:title]).to eq event.name
        expect(json[:start].strftime('%A, %d %B %Y')).to eq event.start_at
        expect(json[:end].strftime('%A, %d %B %Y')).to eq event.end_at
        expect(json[:allDay]).to be_true
        expect(json[:recurring]).to be_false
        expect(json[:url]).to eq helper.bnb_booking_path(booking.bnb, event.booking_id)
        expect(json[:edit_booking_url]).to eq helper.edit_bnb_booking_path(booking.bnb, event.booking_id)
        expect(json[:color]).to eq event.color
      end
    end
  end
end
