# == Schema Information
#
# Table name: users
#
#  id                     :integer          primary key
#  name                   :string(255)
#  email                  :string(255)
#  created_at             :timestamp        not null
#  updated_at             :timestamp        not null
#  password_digest        :string(255)
#  remember_token         :string(255)
#  admin                  :boolean          default(FALSE)
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :timestamp
#  remember_created_at    :timestamp
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :timestamp
#  last_sign_in_at        :timestamp
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  role_id                :integer
#  country                :string(255)
#  contact_number         :string(255)
#  surname                :string(255)
#  authentication_token   :string(255)
#  slug                   :string(255)
#

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
        #plan = FactoryGirl.create(:plan, free: true)
        #role = FactoryGirl.create(:role, description: 'owner')
        #user = FactoryGirl.create(:user, roles: :owner)
        #user.send(:create_subscription)
        #expect(user.subscriptions.count).to eq 1
      end
    end
   end

 end

end
