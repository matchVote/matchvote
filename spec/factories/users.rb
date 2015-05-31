FactoryGirl.define do
  factory :user do
    username "bob"
    email { Faker::Internet.email }
    password "@123abc!"
    password_confirmation "@123abc!"
    admin false
    rep_admin false
    rep_slug ""
    personal_info do
      { first_name: "Bob", 
        last_name: "Jenkins",
        party: "green",
        bio: "hey there" }
    end

    contact
  end
end
