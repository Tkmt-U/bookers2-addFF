class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # FollowingモデルとFollowerモデル
  # followerモデルとFolloweedモデル
  has_many :active_relationship, class_name:"Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :follower, through: :active_relationship, source: :followed
  has_many :passive_relationships, class_name:"Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followed, through: :passive_relationships, source: :follower


  def followed_by?(user)
    passive_relationships.find_by(follower_id: user.id).present?
  end


  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: { maximum: 50 }
end
