class IndexController < ApplicationController
  def index
  end

  def apply_app
    @apple_id = params['apple_id']
    if @apple_id.nil? || (@apple_id.match Feedback::VALID_EMAIL_REGEX).nil?
      render json: {result: "failed"}
    else
      FeedbackMailer.apply_app(@apple_id).deliver_now
      render json: {result: "success", message: "感谢申请！"}
    end
  end
end
