class FeedbackMailer < ApplicationMailer
  def send_to_admin(feedback)
    @user = feedback.user
    @message = feedback.message
    mail subject: "Feedback from #{@user.email}"
  end
end
