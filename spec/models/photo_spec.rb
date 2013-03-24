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

describe Photo do
  pending "add some examples to (or delete) #{__FILE__}"
end
