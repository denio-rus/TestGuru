class FeedbackController < ApplicationController
  def new; end

  def create 
    feedback_message = params[:message]
    if feedback_message.present?
      FeedbackMailer.send_to_admin(feedback_message, current_user).deliver_now
      redirect_to root_path, notice: "Your message was send successfully"
    else
      flash[:alert] = "Do not send empty message."
      render :new 
    end
  end
end
