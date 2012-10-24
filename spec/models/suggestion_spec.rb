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

require 'spec_helper'

describe Suggestion do
  pending "add some examples to (or delete) #{__FILE__}"
end
