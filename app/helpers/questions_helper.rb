module QuestionsHelper

  def question_header(test, question)
    if question.persisted?
      "Edit '#{test.title} test' Question"
    else
      "Create New '#{test.title} test' Question"
    end
  end

  def choose_model(test, question)
    if question.persisted?
      [question]
    else
      [test, question]
    end
  end
end
