class Player < ActiveRecord::Base
  UUID_REGEX = /\A[A-F\d]{8}\-[A-F\d]{4}\-[A-F\d]{4}\-[A-F\d]{4}\-[A-F\d]{12}\z/
  
  has_many :scores
  validates :uid, presence: {value: true, message: 'uid cannot be blank!'},
                  uniqueness: {value: true,message: 'uid already exists!'},
                  format: {with: UUID_REGEX, message: 'wrong uid'}
end
