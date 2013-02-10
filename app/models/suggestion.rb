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

class Suggestion < ActiveRecord::Base
end
