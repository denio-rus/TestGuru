class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true
  has_one :category, through: :test

  scope :all_successful, -> { where(successful: true) }

  before_create :before_create_set_time_to_finish
  before_validation :before_validation_set_next_question
  before_save :set_successful

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
    completed? && percent_of_correct_answers >= 85
  end

  def number_of_questions
    test.questions.count
  end

  def number_of_current_question
    test.questions.where('id <= ?', current_question).count
  end

  def timer?
    test.time_limit.present?
  end

  def rest_of_the_time
    return unless timer?
    
    time_to_finish - Time.current
  end

  private

  def before_validation_set_next_question
    self.current_question = next_question
  end

  def next_question
    return unless in_time?
    
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

  def set_successful
    self.successful = success?
  end

  def time_limit 
    test.time_limit.minutes if timer?
  end

  def in_time?
    return true unless time_to_finish
    
    time_to_finish >= Time.current
  end

  def before_create_set_time_to_finish
    self.time_to_finish = Time.current + time_limit if timer?
  end
end
