require 'spec_helper'

describe Message do
 it 'has a valid factory' do
   expect(FactoryGirl.build(:message)).to be_valid
 end

 #Validations
 describe 'Validations' do
   it { should validate_presence_of(:name)}
   it { should validate_presence_of(:email)}
   it { should validate_presence_of(:subject)}
   it { should validate_presence_of(:body)}

   it { should allow_value('test@test.com', '1test@test.com', 'test@2test.net').for(:email) }
   it { should_not allow_value('abc', '!s@abc.com', 'a@!d.com', 'a@a.c0m').for(:email) }
 end

end
