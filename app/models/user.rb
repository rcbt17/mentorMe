class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :course_subscriptions
  has_many :reviews
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true, length: { minimum: 3, maximum: 25 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 25 }
  validates :nickname, presence: true, uniqueness: true, length: { minimum: 4 }
  validates :job, presence: true, length: { minimum: 4 }
end
