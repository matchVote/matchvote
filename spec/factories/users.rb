FactoryGirl.define do
  factory :user do
    username "bob"
    email { Faker::Internet.email }
    password "@123abc!"
    password_confirmation "@123abc!"
    admin false
    rep_admin false
    personal_info do
      { first_name: "Bob", 
        last_name: "Jenkins",
        party: "green",
        birthday: "11/12/1987",
        bio: "hey there",
        crap_data: :yes }
    end

    trait :with_profile_pic do
      username "jebediah"
      profile_pic File.open(Rails.root.join("spec/support/images/test.jpg"))
    end

    trait :with_contact do
      after(:build) do |user|
        user.build_contact(attributes_for(:contact))
      end
    end

    trait :with_address do
      after(:build) do |user|
        user.contact.postal_addresses.build(attributes_for(:postal_address))
      end
    end

    factory :user_with_pic, traits: [:with_profile_pic]
    factory :user_with_contact, traits: [:with_contact]
    factory :user_with_address, traits: [:with_contact, :with_address]
  end
end

