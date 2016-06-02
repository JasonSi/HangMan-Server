class Feedback < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[A-Za-z\d\-.]+\.[A-Za-z]+\z/
  validates :email, format: { with: VALID_EMAIL_REGEX, unless: :blank_email, message: "错误的邮箱格式"}
  validates :content, presence: true

  def blank_email
    # 如果未传递email参数或者为空字符串，则允许保存
    self.email == "" || self.email.nil?
  end
end
