class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  has_many :posts, class_name: 'Post', foreign_key: 'user_id', dependent: :destroy
  has_many :comments, class_name: 'Comment', foreign_key: 'user_id', dependent: :destroy
end
