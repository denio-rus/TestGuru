module TestPassagesHelper 
  def color_of_result_message(test_passage)
    if test_passage.success?
      'green'
    else
      'red'
    end
  end

  def test_result(test_passage)
    if test_passage.success?
      'passed'
    else
      'failed'
    end
  end
end
