class Message
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :email, :subject, :body

  validates :name, :email, :subject, :body, presence: true
  validates :email, format: {with: %r{.+@.+\..+}}, allow_blank: true

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) } if attributes
  end


  def persisted?
    false
  end

end
