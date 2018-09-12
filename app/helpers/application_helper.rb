module ApplicationHelper
    
  def current_year
    Date.current.year
  end

  def github_link(author, repo)
    link_to author, "https://github.com/#{author}/#{repo}/", target: '_blank'
  end

  def flash_message
    content_tag :p, flash[:alert], class: 'flash alert' if flash[:alert]
  end     
end
