class GistQuestionService

  def initialize(question, client: nil)
    @question = question
    @test = @question.test
    @client = client || Octokit::Client.new(access_token: 'ab9b45103909aaa0aff46e16d74dd528136494ab', api_endpoint: 'https://api.github.com')
  end

  def call
    @client.create_gist(options = gist_params)
  end

  private

  def gist_params
    { description: I18n.t('gist_params.description', test_title: @test.title),
      public: true,
      files: {'test-guru-question.txt' => { content: gist_content } }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end
end