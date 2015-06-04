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
        birthday: "11/12/1987",
        bio: "hey there" }
    end
    contact

    trait :with_profile_pic do
      username "jebediah"
      profile_pic File.open(Rails.root.join("spec/support/images/test.jpg"))
    end

    factory :user_with_pic, traits: [:with_profile_pic]
  end
end

