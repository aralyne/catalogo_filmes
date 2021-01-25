class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable

  include DeviseTokenAuth::Concerns::User
  validates :name, :email, presence: true
  has_many  :movies
  has_many  :addresses
  accepts_nested_attributes_for :addresses

  enum profile: {admin: 0, simple_user: 1, customer: 2}
end
