module TestPassagesHelper 
  def color_of_result_message
    if @test_passage.percent_of_correct_answers >= 85
      'green'
    else
      'red'
    end
  end
end
