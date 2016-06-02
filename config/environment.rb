# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
# 
# # 添加邮件功能
# ActionMailer::Base.delivery_method = :stmp
#
# ActionMailer::Base.server_settings = {
#   :address => "smtp"
# }
