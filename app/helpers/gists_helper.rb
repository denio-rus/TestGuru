module GistsHelper
  def short_question_body(question)
    truncate(question.body, length: 25)
  end

  def gist_hash(gist)
    gist.url.split('/').last
  end
end
