class TestPassage < ApplicationRecord
  attr_writer :time_spent

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true
  has_one :category, through: :test

  scope :all_successful, -> { where(successful: true) }
  
  before_validation :before_validation_set_next_question
  before_save :set_successful

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids) && in_time?
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

  def rest_of_the_time
    return time_limit if time_spent.zero?

    time_limit - time_spent
  end

  def time_limit 
    @time_limit ||= test.time_limit * 60 if timer?
  end

  def time_spent
    Time.now - created_at
  end

  def timer?
    test.time_limit.present?
  end

  private

  def before_validation_set_next_question
    self.current_question = next_question
  end

  def next_question 
    if current_question 
      return if not_in_time?

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

  def in_time?
    return true unless timer?
    return if Time.now - created_at >= time_limit

    time_limit >= time_spent
  end

  def not_in_time? 
    !in_time?
  end
end
