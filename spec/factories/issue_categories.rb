FactoryGirl.define do
  factory :issue_category do
    sequence(:name) { |n| "Issue#{n}" }
  end
end

