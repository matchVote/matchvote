FactoryGirl.define do
  factory :representative do
    first_name { "#{Faker::Name.first_name}#{SecureRandom.hex(5)}" }
    last_name { Faker::Name.last_name }
    nickname { Faker::Name.first_name }
    slug { "#{first_name}-#{last_name}" }
    biography { Faker::Lorem.paragraphs(3).join(" ") }
    government_role "Senator"
    party { ["Republican", "Democrat"].sample }
    birthday "1967-3-8"
    branch "Executive"
    gender "male"
    user_id nil
    name_recognition 0

    contact
  end
end

