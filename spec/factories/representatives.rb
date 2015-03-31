FactoryGirl.define do
  factory :representative do
    first_name "Bob"
    last_name "Buffet"
    nickname "Borky"
    slug "bob-buffet"
    biography Faker::Lorem.paragraphs(3).join(" ")
    government_role "Senator"
    party "Republican"
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

