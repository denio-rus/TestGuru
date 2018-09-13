class SessionsController < AuthController

  before_action :authenticate_user!, only: :destroy

  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to cookies[:start_page]? cookies[:start_page] : root_path
    else
      flash.now[:alert] = 'Are you a Guru? Verify your name and password, please!'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to login_path, notice: 'You have successfully logged out.'
  end
end
