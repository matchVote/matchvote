FactoryGirl.define do
  factory :user do
    username "Bob"
    email "bob@foobar.com"
    password "@123abc!"
    password_confirmation "@123abc!"
    admin false
    rep_admin false
    rep_slug ""
  end
end
