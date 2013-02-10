# == Schema Information
#
# Table name: rooms
#
#  id          :integer          primary key
#  description :string(255)
#  en_suite    :boolean
#  rates       :decimal(, )
#  extras      :string(255)
#  created_at  :timestamp        not null
#  updated_at  :timestamp        not null
#  bnb_id      :integer
#  room_number :integer
#  available   :boolean          default(TRUE)
#  capacity    :integer          default(2)
#

require 'spec_helper'

describe Room do
  pending "add some examples to (or delete) #{__FILE__}"
end
