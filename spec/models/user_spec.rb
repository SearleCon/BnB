require 'spec_helper'

describe User do
 it 'has a valid factory' do
   expect(FactoryGirl.create(:user)).to be_valid
 end

 #Relationships
 describe 'Relationships' do
   it { should have_many(:subscriptions) }
 end

 #Validations
 describe 'Validations' do
   it { should validate_acceptance_of(:terms_of_service)}
 end

 #Callbacks
 describe 'Callbacks' do

   describe 'after_create' do
    it { described_class._create_callbacks.select { |cb| cb.kind.eql?(:after) }.collect(&:filter).should include(:create_subscription) }

    describe '#create_subscription' do
      it 'should create a free trial' do
        plan = FactoryGirl.create(:plan, free: true)
        role = FactoryGirl.create(:role, description: 'owner')
        user = FactoryGirl.create(:user, roles: :owner)
        user.send(:create_subscription)
        expect(user.subscriptions.count).to eq 1
      end
    end
   end

 end

end
