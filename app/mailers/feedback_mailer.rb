class FeedbackMailer < ApplicationMailer
  def send_to_admin(feedback_message, current_user)
    @user = current_user
    @message = feedback_message
    mail to: "admin@admin.comm", subject: "Feedback from #{@user.email}"
  end
end
