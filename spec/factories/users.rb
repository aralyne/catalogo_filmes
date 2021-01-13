FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user #{n}" }
    sequence(:email) { |n| "aralynegs#{n}@gmail.com" }
    password { '123123123' }
    profile { 'admin' }
  end
end