# == Schema Information
#
# Table name: suggestions
#
#  id         :integer          primary key
#  suggestion :text
#  user_id    :integer
#  created_at :timestamp        not null
#  updated_at :timestamp        not null
#  subject    :string(255)
#

require 'spec_helper'

describe Suggestion do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:suggestion)).to be_valid
  end
end
