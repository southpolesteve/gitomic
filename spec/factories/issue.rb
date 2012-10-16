FactoryGirl.define do
  factory :issue do
    title "Test Issue"
    body "Test issue body"
    project
    sequence(:number)
  end
end