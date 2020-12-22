class User < ApplicationRecord
        extend Devise::Models
            # Include default devise modules.
            devise :database_authenticatable, :registerable,
                    :recoverable, :rememberable, :validatable,
                    :omniauthable
            include DeviseTokenAuth::Concerns::User
    validates :name, :email, presence: true
end
