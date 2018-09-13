module ApplicationHelper
    
  def current_year
    Date.current.year
  end

  def github_link(author, repo)
    link_to author, "https://github.com/#{author}/#{repo}/", target: '_blank'
  end

  def flash_message(key)
    content_tag :p, flash[key.to_sym], class: "flash #{key}" if key.present?
  end     
end
