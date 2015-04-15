require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    name 'name'
    password 'password'
    password_confirmation 'password'
  end

  factory :product do
    sequence(:name) { |n| "Tools#{n}" }
    description "a great toolset"
    price "10"
    user
  end
end
