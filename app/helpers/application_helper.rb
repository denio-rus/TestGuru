module ApplicationHelper
    
  def current_year
    Date.current.year
  end

  def github_link(author, repo)
    link_to author, "https://github.com/#{author}/#{repo}/", target: '_blank'
  end

  def link_to_admin_panel
    link_to t('nav_bar.link_admin_panel'), admin_tests_path, class: "nav-link active" if current_user.admin?
  end

  def alert_type(alert_key)
    alert_key == 'notice' ? 'success' : 'danger' 
  end
end
