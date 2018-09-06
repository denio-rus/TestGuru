class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

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

  def test_result
    if percent_of_correct_answers >= 85
      'passed'
    else 
      'failed'
    end
  end

  def number_of_questions
    test.questions.count
  end

  def number_of_current_question
    test.questions.where('id <= ?', current_question).count
  end

  private

  def before_validation_set_next_question
    if current_question 
      self.current_question = test.questions.order(:id).where('id > ?', current_question.id).first
    else
      self.current_question = test.questions.first if test.present?
    end    
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == Array(answer_ids).map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end
end
