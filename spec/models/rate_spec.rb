require 'spec_helper'

describe Rate do
 it 'has a valid factory' do
   expect(FactoryGirl.create(:rate)).to be_valid
 end

 #Relationships
 describe 'Relationships' do
  it { should belong_to(:rateable) }
 end

 #Validations
 describe 'Validations' do
  it { should validate_presence_of(:description) }

  it { should allow_value(50).for(:price) }
  it { should allow_value(0.55).for(:price) }
  it { should allow_value(1.23).for(:price) }

  it { should_not allow_value('test').for(:price) }
  it { should_not allow_value('1,0').for(:price) }
 end

 #Callbacks
 describe 'Callbacks' do
   describe 'after_initialize' do
    it { described_class._initialize_callbacks.select{|cb| cb.kind.eql?(:after)}.collect(&:filter).should include(:default_values) }
    describe '#default_values' do
      it 'should set active to true if it is a new record' do
        rate = FactoryGirl.build(:rate, active: nil)
        rate.send(:default_values)
        expect(rate.active).to be_true
      end

      it 'should set active to true if it is a new record' do
        rate = FactoryGirl.create(:rate, active: false)
        rate.send(:default_values)
        expect(rate.active).to_not be_true
      end
    end
   end
 end

 #Instance Methods
 describe 'Instance Methods' do
   describe '#rate_info' do
     it 'should return a combination of the description and the price formatted to currency' do
       rate = FactoryGirl.build(:rate, description: 'Test', price: 1)
       expect(rate.rate_info).to eq 'Test R1.00'
     end
   end
 end
end
