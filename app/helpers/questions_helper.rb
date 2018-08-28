module QuestionsHelper

  def question_header(question)
    if question.persisted?
      "Edit '#{question.test.title} test' Question"
    else
      "Create New '#{question.test.title} test' Question"
    end
  end

  def choose_model(question)
    if question.persisted?
      question
    else
      [question.test, question]
    end
  end
end
