FactoryBot.define do
  factory :movie do
    sequence(:title) { |n| "Movie #{n}" }
    sequence(:description) { |n| "Description #{n}" }
  end
end
