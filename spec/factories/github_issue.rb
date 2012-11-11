FactoryGirl.define do
  factory :github_issue, class: Github::Issue do
  
    number 1
    state "open"
    labels []
    title "Test Title"
    body "Test Body"
    created_at { Time.now.to_s }

    ignore do
      owner "gitomic-test"
      repo_name "gitomic-test"
    end

    # UNUSED IN FACTORY
    # user
    # labels
    # url
    # assignee
    # closed_at
    # id
    # updated_at
    # milestone

    initialize_with { new(owner, repo_name, Hashie::Mash.new(attributes)) }
  end
end