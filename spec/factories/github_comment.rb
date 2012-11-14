FactoryGirl.define do
  factory :github_comment, class: Github::Comment do
  
    sequence(:id)
    title "Test Title"
    body "test comment body"
    created_at { Time.now.to_s }
    updated_at { Time.now.to_s }

    ignore do
      owner "gitomic-test"
      repo_name "gitomic-test"
      issue_number 123
    end

    initialize_with { new(owner, repo_name , issue_number, Hashie::Mash.new(attributes)) }
  end
end