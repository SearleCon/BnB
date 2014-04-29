# == Schema Information
#
# Table name: bnbs
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  description      :text
#  email            :string(255)
#  address_line_one :string(255)
#  address_line_two :string(255)
#  city             :string(255)
#  postal_code      :string(255)
#  country          :string(255)
#  telephone_number :string(255)
#  website          :string(255)
#  contact_person   :string(255)
#  twitter_account  :string(255)
#  facebook_page    :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#  latitude         :float
#  longitude        :float
#  rating           :integer
#  region           :string(255)
#  slug             :string(255)
#  approved         :boolean          default(FALSE)
#  mappable         :boolean          default(FALSE)
#  photos_count     :integer          default(0)
#

require 'spec_helper'

describe Bnb do

   it "has a valid factory" do
     expect(FactoryGirl.create(:bnb)).to be_valid
   end

   # Relationships
   it { should have_many(:guests).dependent(:delete_all) }
   it { should have_many(:photos).dependent(:delete_all) }
   it { should have_many(:rooms).dependent(:delete_all) }
   it { should have_many(:bookings).dependent(:delete_all) }
   it { should have_many(:rates) }

   # Nested Attributes
  it { should accept_nested_attributes_for(:rates).allow_destroy(true) }

  # Validations
  describe 'Validations' do
    describe 'Bnb Details' do
      context 'active' do
        before { subject.stub(:active_or_bnb_details?) { true } }
        it { should validate_presence_of(:name) }
        it { should validate_presence_of(:description) }
      end

      context 'inactive' do
        before { subject.stub(:active_or_bnb_details?) { false } }
        it { should_not validate_presence_of(:name) }
        it { should_not validate_presence_of(:description) }
      end

      describe '#active_or_bnb_details?' do
        context 'true' do
          it 'is true when status is bnb_details' do
            bnb = FactoryGirl.build(:bnb)
            bnb.status = 'bnb_details'
            expect(bnb.send(:active_or_bnb_details?)).to be_true
          end

          it 'is true when status is active' do
            bnb = FactoryGirl.build(:bnb)
            bnb.status = 'active'
            expect(bnb.send(:active_or_bnb_details?)).to be_true
          end
        end
        context 'false' do
          it 'is false when status is contact_details' do
            bnb = FactoryGirl.build(:bnb)
            bnb.status = 'contact_details'
            expect(bnb.send(:active_or_bnb_details?)).to be_false
          end

          it 'is false when status is inactive' do
            bnb = FactoryGirl.build(:bnb)
            bnb.status = 'inactive'
            expect(bnb.send(:active_or_bnb_details?)).to be_false
          end
        end
      end

      describe '#active_or_contact_details?' do
        context 'true' do
          it 'is true when status is contact_details' do
            bnb = FactoryGirl.build(:bnb)
            bnb.status = 'contact_details'
            expect(bnb.send(:active_or_contact_details?)).to be_true
          end

          it 'is true when status is active' do
            bnb = FactoryGirl.build(:bnb)
            bnb.status = 'active'
            expect(bnb.send(:active_or_contact_details?)).to be_true
          end
        end
        context 'false' do
          it 'is false when status is bnb_details' do
            bnb = FactoryGirl.build(:bnb)
            bnb.status = 'bnb_details'
            expect(bnb.send(:active_or_contact_details?)).to be_false
          end

          it 'is false when status is inactive' do
            bnb = FactoryGirl.build(:bnb)
            bnb.status = 'inactive'
            expect(bnb.send(:active_or_contact_details?)).to be_false
          end
        end
      end
    end

    describe 'Contact Details' do
      context 'active' do
        before { subject.stub(:active_or_contact_details?) { true } }
        it { should validate_presence_of(:contact_person) }
        it { should validate_presence_of(:email) }
        it { should validate_presence_of(:telephone_number) }
        it { should validate_presence_of(:address_line_one) }
        it { should validate_presence_of(:address_line_two) }
        it { should validate_presence_of(:city) }
        it { should validate_presence_of(:postal_code) }
      end

      context 'inactive' do
        before { subject.stub(:active_or_contact_details?) { false } }
        it { should_not validate_presence_of(:contact_person) }
        it { should_not validate_presence_of(:email) }
        it { should_not validate_presence_of(:telephone_number) }
        it { should_not validate_presence_of(:address_line_one) }
        it { should_not validate_presence_of(:address_line_two) }
        it { should_not validate_presence_of(:city) }
        it { should_not validate_presence_of(:postal_code) }
      end
    end
  end

  # CallBacks
  describe 'Callbacks' do
    describe 'after_initialize' do
      it { described_class._initialize_callbacks.select{|cb| cb.kind.eql?(:after)}.collect(&:filter).should include(:default_values) }

      describe '#default_values' do
        context 'new record' do
          it 'should default to inactive' do
            bnb = FactoryGirl.build(:bnb)
            expect(bnb.status).to eq 'inactive'
          end
        end

        context 'existing record' do
          it 'should default to active' do
            bnb = FactoryGirl.create(:bnb)
            bnb = Bnb.first
            expect(bnb.status).to eq 'active'
          end
        end

      end
    end
    describe 'before_validation' do
      it { described_class._validation_callbacks.select{|cb| cb.kind.eql?(:before)}.collect(&:filter).should include(:normalize_blank_values) }

      describe '#normalize_blank_values' do
        it 'should set blank values to nil' do
          bnb = FactoryGirl.build(:bnb, website: '  ')
          bnb.send(:normalize_blank_values)
          expect(bnb.website).to be_nil
        end
      end
    end
    describe 'after_commit' do
      it { described_class._commit_callbacks.select{|cb| cb.kind.eql?(:after)}.collect(&:filter).should include(:fetch_address) }


    describe '#address_changed?' do
      it 'should return true when the address has changed' do
        bnb = FactoryGirl.create(:bnb)
        bnb.address_line_one = '25 Lukin Rd'
        bnb.save
        expect(bnb.send(:address_changed?)).to be_true
      end

      it 'should return false unless the address has changed' do
        bnb = FactoryGirl.create(:bnb)
        bnb.website = ''
        bnb.save
        expect(bnb.send(:address_changed?)).to be_false
      end
    end

    describe '#fetch_address' do
      it 'should create a Process Address Job' do
        bnb = FactoryGirl.create(:bnb)
        bnb.send(:fetch_address)
        expect(Delayed::Job.last.handler).to include(ProcessAddressJob.to_s)
      end
    end
  end
  end

  # Scopes
  describe 'Scopes' do
    describe '.approved' do
      context 'approved bnbs' do
        it 'should return approved bnbs' do
          bnb = FactoryGirl.create(:bnb)
          expect(Bnb.approved).to eq [bnb]
        end
      end

      context 'no approved bnbs' do
        it 'should return approved bnbs' do
          bnb = FactoryGirl.create(:bnb, approved: false)
          expect(Bnb.approved).to_not eq [bnb]
        end
      end
    end
  end

  # Instance Methods
  describe 'Instance Methods' do
    describe '#full_address' do
      it 'should return full address as a string' do
        bnb = FactoryGirl.build(:bnb, address_line_one: '25 Lukin Rd', address_line_two: 'Selborne', city: 'East London', postal_code: '5201', country: 'South Africa')
        expect(bnb.full_address).to eq "25 Lukin Rd,Selborne,East London,5201,South Africa"
      end

      it 'should ignore nil values in the address fields' do
        bnb = FactoryGirl.build(:bnb, address_line_one: '25 Lukin Rd', address_line_two: 'Selborne', city: 'East London', postal_code: nil, country: 'South Africa')
        expect(bnb.full_address).to eq "25 Lukin Rd,Selborne,East London,South Africa"
      end

    end

    describe '#co_ordinates' do
      it 'should return co_ordinates as a string' do
        bnb = FactoryGirl.build(:bnb, latitude: '1234', longitude: '1234')
        expect(bnb.co_ordinates).to eq "1234.0,1234.0"
      end

      it 'should ignore nil values in the latitude and longitude fields' do
        bnb = FactoryGirl.build(:bnb, latitude: '1234', longitude: nil)
        expect(bnb.co_ordinates).to eq "1234.0"
      end

    end
  end

end
