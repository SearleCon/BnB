# == Schema Information
#
# Table name: photos
#
#  id          :integer          not null, primary key
#  description :string(255)
#  image       :string(255)
#  order       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  bnb_id      :integer
#

require 'spec_helper'

describe Photo do
  pending "add some examples to (or delete) #{__FILE__}"
end
