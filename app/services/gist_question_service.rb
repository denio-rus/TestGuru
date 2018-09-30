class GistQuestionService

  def initialize(question, client: default_client)
    @question = question
    @test = @question.test
    @client = client 
  end

  def call
    GitHubResponse.new(@client.create_gist(gist_params))
  end

  private

  def gist_params
    { description: I18n.t('gist_params.description', test_title: @test.title),
    public: true,
    files: {'test-guru-question.txt' => { content: gist_content } } }
  end

  def gist_content
    [@question.body, *@question.answers.pluck(:body)].join("\n")
  end

  def default_client
    Octokit::Client.new(access_token: ENV['GIST_TOKEN'])
  end

  class GitHubResponse 
    attr_reader :response
  
    def initialize(response)
      @response = response   
    end
  
    def success? 
      @response.html_url.present?
    end
  
    def gist_url
      @response.html_url
    end
  end
end