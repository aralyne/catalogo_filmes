class Movie < ApplicationRecord
    validates :title,:description, presence: true
    belongs_to :category, optional: true
end

