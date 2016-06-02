class FeedbackMailer < ApplicationMailer
  JASON_EMAIL = ENV["jason_email"]
  COKILE_EMAIL = ENV["cokile_email"]
  default to: Proc.new { [JASON_EMAIL, COKILE_EMAIL].compact }
  
  def send_feedback(feedback)
    @feedback = feedback
    mail(subject: "Feedback For HangMan")
  end
end
