class GitHubClientResponseAdapter 
  attr_reader :response

  def initialize(question)
    @response = GistQuestionService.new(question).call    
  end

  def success? 
    @response.html_url.present?
  end

  def gist_url
    @response.html_url
  end

  def gist_hash
    @response.id
  end
end