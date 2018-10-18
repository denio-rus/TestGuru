class Feedback 
  include ActiveModel::Model
  # id for render errors
  attr_reader :user, :message, :id

  validates :user, :message, presence: true

  def initialize (user, message, id = 'none')
    @user = user
    @message = message
  end
end
