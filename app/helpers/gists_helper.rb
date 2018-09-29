module GistsHelper
  def short_question_body(question)
    question.body[0,25]
  end
end
