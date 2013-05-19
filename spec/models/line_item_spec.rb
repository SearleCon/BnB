# == Schema Information
#
# Table name: line_items
#
#  id          :integer          primary key
#  description :string(255)
#  value       :decimal(, )
#  booking_id  :integer
#  created_at  :timestamp        not null
#  updated_at  :timestamp        not null
#

require 'spec_helper'

describe LineItem do

  it 'should have a valid factory' do
    expect(FactoryGirl.create(:line_item)).to be_valid
  end

  #Relationships
  it { should belong_to(:booking) }

  #Validations
  describe 'Validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:value) }
  end

  #Instance Methods
  describe 'Instance Methods' do
    describe '#to_currency' do
      it 'should format value into currency' do
        line_item = FactoryGirl.build(:line_item)
        expect(line_item.to_currency).to eq helper.number_to_currency(line_item.value, precision: 2)
      end
    end
  end
end
