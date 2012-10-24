# == Schema Information
#
# Table name: suggestions
#
#  id         :integer          not null, primary key
#  suggestion :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  subject    :string(255)
#

class Suggestion < ActiveRecord::Base
end
