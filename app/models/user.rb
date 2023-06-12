class User < ApplicationRecord
  has_many :posts, foreign_key: 'author', dependent: :destroy
  has_many :comments, foreign_key: 'user_id'
  has_many :comment_id, through: :comment, source: 'Post'
  has_many :likes, foreign_key: 'user_id'
  has_many :friendships
  has_many :confirmed_friends, -> { where(friendships: { friendship_status: true }) }, through: :friendships, source: :friend
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_confirmed_friends, -> { where(friendships: { friendship_status: true }) }, through: :inverse_friendships, source: :user

  has_one_attached :profile_picture
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :all_except, ->(user) { where.not(id: user) }
  
  def friends_and_own_posts
    Post.where(user: (confirmed_friends + inverse_confirmed_friends + [self]))
  end

  validates :username, presence: true
      
      
end
