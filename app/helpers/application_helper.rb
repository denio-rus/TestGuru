module ApplicationHelper
    
  def show_year
    Date.today.year 
  end

  def github_url(project, repo)
    link_to project, repo, target: '_blank'
  end
end
