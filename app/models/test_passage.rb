class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true
  has_many :achievements
  has_one :category, through: :test

  scope :all_successful, -> { where(successful: true) }
  
  before_validation :before_validation_set_next_question

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    save!
  end

  def completed?
    current_question.nil?
  end

  def percent_of_correct_answers
    correct_questions.to_f / test.questions.count * 100
  end

  def success?
    percent_of_correct_answers >= 85
  end

  def number_of_questions
    test.questions.count
  end

  def number_of_current_question
    test.questions.where('id <= ?', current_question).count
  end

  private

  def before_validation_set_next_question
    self.current_question = next_question
  end

  def next_question 
    if current_question 
      test.questions.order(:id).where('id > ?', current_question.id).first
    else
      test.questions.first if test.present?
    end
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == Array(answer_ids).map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end
end
