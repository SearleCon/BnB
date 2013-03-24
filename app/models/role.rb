# == Schema Information
#
# Table name: roles
#
#  id          :integer          primary key
#  description :string(255)
#  created_at  :timestamp        not null
#  updated_at  :timestamp        not null
#

class Role < ActiveRecord::Base
end
