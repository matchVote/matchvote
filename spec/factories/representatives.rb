FactoryGirl.define do
  factory :representative do
    first_name "Bob"
    last_name "Buffet"
    nickname "Borky"
    slug "bob-buffet"
    biography Faker::Lorem.paragraphs(3)
    government_role "Senator"
    party "Republican"
    birthday "1967-3-8"
    contact
  end
end

