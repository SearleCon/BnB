# == Schema Information
#
# Table name: photos
#
#  id          :integer          primary key
#  description :string(255)
#  image       :string(255)
#  created_at  :timestamp        not null
#  updated_at  :timestamp        not null
#  bnb_id      :integer
#  main        :boolean          default(FALSE)
#  processed   :boolean          default(FALSE)
#

require 'spec_helper'

#TODO CarrierWave Testing
describe Photo do
 it 'has a valid factory' do
   expect(FactoryGirl.create(:photo)).to be_valid
 end

 #Relationships
 it { should belong_to(:bnb).touch(true) }

 #Validations
 describe 'Validations' do
   it { should validate_presence_of(:description) }
 end

 #Callbacks
 describe 'Callbacks' do

   describe 'before_save' do
     it { described_class._save_callbacks.select{|cb| cb.kind.eql?(:before)}.collect(&:filter).should include(:set_previous_main_to_false) }

     describe '#set_previous_main_to_false' do
       it 'should fetch the previous main photo and set to false' do
         bnb = FactoryGirl.create(:bnb)
         old_photo = FactoryGirl.create(:photo, main: true, bnb_id: bnb.id)
         new_photo = FactoryGirl.build(:photo, main: true, bnb_id: bnb.id)
         new_photo.send(:set_previous_main_to_false)
         old_photo.reload
         expect(old_photo.main).to be_false
       end
     end
   end

   describe 'after_destroy' do
     it { described_class._destroy_callbacks.select{|cb| cb.kind.eql?(:after)}.collect(&:filter).should include(:destroy_file) }
   end
 end

 #Scopes
 describe 'Scopes' do
   describe 'main_photo' do
     it 'should should return photos marked as main' do
       photo = FactoryGirl.create(:photo, main: true)
       expect(Photo.main_photo).to eq [photo]
     end

     it 'should should return photos marked as main' do
       photo = FactoryGirl.create(:photo, main: false)
       expect(Photo.main_photo).to_not eq [photo]
     end
   end
   describe 'support_photos' do
     it 'should should return photos not marked as main' do
       photo = FactoryGirl.create(:photo, main: false)
       expect(Photo.support_photos).to eq [photo]
     end

     it 'should should return photos not marked as main' do
       photo = FactoryGirl.create(:photo, main: true)
       expect(Photo.support_photos).to_not eq [photo]
     end
   end
   describe 'processed' do
     it 'should should return photos marked as processed' do
       photo = FactoryGirl.create(:photo, processed: true)
       expect(Photo.processed).to eq [photo]
     end

     it 'should should return photos marked as processed' do
       photo = FactoryGirl.create(:photo, processed: false)
       expect(Photo.processed).to_not eq [photo]
     end
   end
 end


end
