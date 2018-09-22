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
      t('test_passages.passed')
    else
      t('test_passages.failed')
    end
  end
end
