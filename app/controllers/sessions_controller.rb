class SessionsController < Devise::SessionsController
  def create
    super do |current_user|
      flash.notice = "Привет, #{current_user.first_name}"
    end
  end
end