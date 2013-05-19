# == Schema Information
#
# Table name: roles
#
#  id          :integer          primary key
#  description :string(255)
#  created_at  :timestamp        not null
#  updated_at  :timestamp        not null
#

require 'spec_helper'

describe Role do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:role)).to be_valid
  end
end
