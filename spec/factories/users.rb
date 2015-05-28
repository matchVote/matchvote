FactoryGirl.define do
  factory :user do
    username "Bob"
    email { Faker::Internet.email }
    password "@123abc!"
    password_confirmation "@123abc!"
    admin false
    rep_admin false
    rep_slug ""
  end
end
