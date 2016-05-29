class Player < ActiveRecord::Base
  has_many :scores
  validates :uid, presence: {value: true, message: 'uid cannot be blank!'},
                  uniqueness: {value: true,message: 'uid already exists!'}
end
