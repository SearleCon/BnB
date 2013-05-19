# == Schema Information
#
# Table name: guests
#
#  id             :integer          primary key
#  name           :string(255)
#  surname        :string(255)
#  contact_number :string(255)
#  created_at     :timestamp        not null
#  updated_at     :timestamp        not null
#  bnb_id         :integer
#  user_id        :integer
#  email          :string(255)
#  slug           :string(255)
#

require 'spec_helper'

describe Guest do
 it 'has a valid factory' do
   expect(FactoryGirl.create(:guest)).to be_valid
 end

 #Relationships
 it { should belong_to(:bnb) }
 it { should have_many(:bookings).dependent(:destroy) }
 it { should have_many(:rooms).through(:bookings) }

 #Validations
 describe 'Validations' do

   it { should validate_presence_of(:name) }
   it { should validate_presence_of(:surname) }

   it { should validate_numericality_of(:contact_number) }
   it { should ensure_length_of(:contact_number).is_equal_to(10) }

   it { should allow_value('test@test.com', '1test@test.com', 'test@2test.net').for(:email) }
   it { should_not allow_value('abc', '!s@abc.com', 'a@!d.com', 'a@a.c0m').for(:email) }
 end

 #Callbacks
 describe 'Callbacks' do
     describe 'before_save' do
       it { described_class._save_callbacks.select{|cb| cb.kind.eql?(:before)}.collect(&:filter).should include(:capitalize_names) }

       describe '#capitalize names' do
           it 'should capitalize name and surname' do
             guest = FactoryGirl.create(:guest, name: 'bob', surname: 'smith')
             guest.send(:capitalize_names)
             expect(guest.name).to include 'bob'.capitalize
             expect(guest.surname).to include 'smith'.capitalize
           end
       end
     end
 end

 #Instance Methods
 describe 'Instance Methods' do
   describe '#full_name' do
    it 'should return a string containing name and surname' do
      guest = FactoryGirl.create(:guest, name: 'bob', surname: 'smith')
      expect(guest.full_name).to eq 'Bob Smith'
    end
   end
 end
end
