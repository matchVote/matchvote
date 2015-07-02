FactoryGirl.define do
  factory :statement do
    id { Random.rand(10_000) }
    text "Some statement"
    issue_category
  end
end

