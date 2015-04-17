FactoryGirl.define do
  factory :contact do
    phone_numbers ["123-123-1234"]
    emails ["hey@gobo.com"]
    website_url "http://wompus.com"

    after(:create) do |contact|
      create_list(:postal_address, 1, contact: contact)
    end
  end
end

