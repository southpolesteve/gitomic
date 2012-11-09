FactoryGirl.define do
  factory :project do
    owner "gitomic-test"
    name "gitomic-test"
    org false
    creator { FactoryGirl.create(:test_user) }
  end

  factory :project_rails do
    owner "rails"
    name "rails"
    org true
  end


  factory :org_project, class: Project do
    owner "gitomic-test-organization"
    name "gitomic-test-org-repo"
    org true
  end
end