class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :max_number_of_aswers, on: :create

  scope :correct, -> { where(correct: true) }

  def max_number_of_aswers
    if question.answers.count == 4
      errors.add(:question_id, "Reached max number of answers for this question")
    end
  end
end
