FactoryGirl.define do
  factory :representative do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    nickname { Faker::Name.first_name }
    slug { "#{first_name}-#{last_name}" }
    biography { Faker::Lorem.paragraphs(3).join(" ") }
    government_role "Senator"
    party { ["Republican", "Democrat"].sample }
    birthday "1967-3-8"
    branch "Executive"
    external_credentials do 
      { twitter_username:  "tweet", 
        facebook_username: "facebook", 
        youtube_username:  "youtubes" }
    end

    contact
  end
end

