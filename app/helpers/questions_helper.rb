module QuestionsHelper

  def question_header
    if action_name == "edit"
      "Edit '#{@test.title} test' Question"
    else
      "Create New '#{@test.title} test' Question"
    end
  end
end
