require 'spec_helper'

describe Suggestion do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:suggestion)).to be_valid
  end
end
