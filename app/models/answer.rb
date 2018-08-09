class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :max_number_of_aswers

  scope :correct, -> { where(correct: true) }

  def max_number_of_aswers
    if Answer.where(question_id: question_id).size == 4
      errors.add(:question_id, "Reached max number of answers for this question")
    end
  end
end
