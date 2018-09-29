class GitHubClientAdapter
  attr_reader :octokit_result

  def initialize
    Octokit::Client.new(access_token: 'ab9b45103909aaa0aff46e16d74dd528136494ab', api_endpoint: 'https://api.github.com')
  end

  def success?
    true
  end
end

        