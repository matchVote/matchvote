FactoryGirl.define do
  factory :contact do
    phone_numbers ["123-123-1234"]
    emails ["hey@gobo.com"]
    website_url "http://wompus.com"
    external_ids do 
      { twitter_username:  "tweet", 
        facebook_username: "facebook", 
        youtube_username:  "youtubes" }
    end

    after(:create) do |contact|
      create_list(:postal_address, 1, contact: contact)
    end

    after(:build) do |contact|
      build_list(:postal_address, 1, contact: contact)
    end
  end
end

