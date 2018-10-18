class FeedbackController < ApplicationController
  def new; end

  def create 
    @feedback = Feedback.new(current_user, params[:message])
    if @feedback.valid?
      FeedbackMailer.send_to_admin(@feedback).deliver_now
      redirect_to root_path, notice: "Your message was send successfully"
    else
      flash.now.alert = "Your message was not sent"
      render :new 
    end
  end
end
