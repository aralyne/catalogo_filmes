FactoryBot.define do
  factory :address do
    street { "MyString" }
    cep { "MyString" }
    city { "MyString" }
    neighborhood { "MyString" }
    number { "MyString" }
    user { nil }
  end
end