class AuthController < ApplicationController
  before_action :authenticate_user!

  private
  
  def authenticate_user!
    unless current_user
      cookies[:start_page] = request.url
      redirect_to login_path, alert: 'Are you a Guru? Verify your name and password, please!'
    end
  end
end
