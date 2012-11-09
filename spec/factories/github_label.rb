FactoryGirl.define do
  factory :github_label, class: Github::Label do
    color '#333333'
    name 'bug'

    ignore do
      owner "gitomic-test"
      repo_name "gitomic-test"
    end

    initialize_with { new(owner, repo_name, Hashie::Mash.new(attributes)) }

  end
end