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
        bio: "hey there",
        crap_data: :yes }
    end
    contact

    trait :with_profile_pic do
      username "jebediah"
      profile_pic File.open(Rails.root.join("spec/support/images/test.jpg"))
    end

    trait :without_address do
      username { Faker::Name.first_name }
      after(:create) do |user|
        user.contact.postal_addresses.destroy_all
      end
    end

    factory :user_with_pic, traits: [:with_profile_pic]
    factory :user_without_address, traits: [:without_address]
  end
end

