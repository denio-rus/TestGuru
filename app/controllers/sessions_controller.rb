class SessionsController < ApplicationController

  skip_before_action :authenticate_user!, only: %i[new create]

  def new
    cookies[:start_page] = root_path
  end

  def create
    user = User.find_by(username: params[:username])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to cookies[:start_page]
    else
      flash.now[:alert] = 'Are you a Guru? Verify your name and password, please!'
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to login_path, alert: 'You have successfully logged out.'
  end
end
