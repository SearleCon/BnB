require 'spec_helper'

describe Subscription do

  it 'has a valid factory' do
    expect(FactoryGirl.create(:subscription)).to be_valid
  end

  #Relationships
  describe 'Relationships' do
    it { should belong_to(:plan) }
    it { should belong_to(:user) }
  end

  #CallBacks
  describe 'Callbacks' do
    describe 'before_create' do
      it { described_class._create_callbacks.select { |cb| cb.kind.eql?(:before) }.collect(&:filter).should include(:set_expiry_date) }
      it { described_class._create_callbacks.select { |cb| cb.kind.eql?(:before) }.collect(&:filter).should include(:deactivate_previous_subscription) }


      describe '#set_expiry_date' do
        it 'should set the expiry date if the record is new' do
          plan = FactoryGirl.create(:plan, duration: 2)
          subscription = FactoryGirl.build(:subscription, plan: plan)
          subscription.send(:set_expiry_date)
          expect(subscription.expiry_date).to_not be_nil
          expect(subscription.expiry_date.round).to eq (Time.zone.now + plan.duration.months).round
        end
      end

      describe '#deactivate_previous_subscription' do
        it 'should deactivate the previous subscription' do
          old_subscription = FactoryGirl.create(:subscription)
          new_subscription = FactoryGirl.create(:subscription)
          new_subscription.send(:deactivate_previous_subscription)
          old_subscription.reload
          expect(old_subscription.active_profile).to be_false
        end
      end

    end
  end

  #Scopes
  describe 'Scopes' do
    describe 'default_scope' do

      it 'should default to active when built' do
        expect(FactoryGirl.build(:subscription).active_profile).to be_true
      end

      it 'should only return active subscriptions' do
        subscription = FactoryGirl.create(:subscription, active_profile: true)
        expect(Subscription.all).to eq [subscription]
      end
      it 'should only return active subscriptions' do
        subscription = FactoryGirl.create(:subscription, active_profile: false)
        expect(Subscription.all).to_not eq [subscription]
      end
    end
  end

end
