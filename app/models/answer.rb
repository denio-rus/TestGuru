class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :max_number_of_answers, on: :create

  scope :correct, -> { where(correct: true) }

  def max_number_of_answers
    errors.add(:question_id, "Reached max number of answers for this question") if question.answers.count == 4
  end
end
