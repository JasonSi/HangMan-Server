class AppKey < ActiveRecord::Base
  validates :key, uniqueness: true, presence: true
  validates :title, length: {maximum: 20}
end
