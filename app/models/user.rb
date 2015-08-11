class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :squawks
  validates_uniqueness_of :username
  validates_uniqueness_of :email

  acts_as_followable
  acts_as_follower

  def cannot_follow?(user)
    user.blocks.include?(user)
  end

end
