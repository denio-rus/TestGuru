module ApplicationHelper
    
  def current_year
    Date.current.year
  end

  def github_link(author, repo)
    link_to author, "https://github.com/#{author}/#{repo}/", target: '_blank'
  end

  def alert_type(alert_key)
    alert_key == 'notice' ? 'success' : 'danger' 
  end
end
