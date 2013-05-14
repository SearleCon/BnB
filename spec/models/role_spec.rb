require 'spec_helper'

describe Role do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:role)).to be_valid
  end
end
