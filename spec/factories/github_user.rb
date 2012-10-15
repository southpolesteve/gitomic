FactoryGirl.define do
  factory :github_test_user, class: Github::User do
    login "gitomic-test"

    initialize_with { new(Hashie::Mash.new(attributes)) }
  end

  factory :github_test_user_2, class: Github::User do
    login "gitomic-test-2"

    initialize_with { new(Hashie::Mash.new(attributes)) }
  end
end