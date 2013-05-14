require 'spec_helper'

describe Plan do
 it 'has a valid factory' do
   expect(FactoryGirl.create(:plan)).to be_valid
 end

 #Relationships
 describe 'Relationships' do
   it { should have_many(:subscriptions) }
 end

 #Scopes
 describe 'Scopes' do
   describe 'free_trial' do
     it 'returns plans marked as free' do
       plan = FactoryGirl.create(:plan, free: true)
       expect(plan.free).to be_true
     end

     it 'returns plans marked as free' do
       plan = FactoryGirl.create(:plan, free: false)
       expect(plan.free).to_not be_true
     end
   end
 end
end
