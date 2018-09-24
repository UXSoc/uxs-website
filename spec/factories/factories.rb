FactoryBot.define do
  factory :user do
    email { |i| "janedoe_#{i}@uxsociety.org" }
    password "password"
    password_confirmation "password"
  end
end
