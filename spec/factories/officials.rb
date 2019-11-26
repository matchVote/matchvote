FactoryGirl.define do
  factory :official do
    mv_key { SecureRandom.hex(5) }
    first_name { "#{Faker::Name.first_name}#{SecureRandom.hex(5)}" }
    last_name { Faker::Name.last_name }
  end
end

