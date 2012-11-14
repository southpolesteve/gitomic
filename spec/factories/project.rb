FactoryGirl.define do
  factory :project do
    owner "gitomic-test"
    name "gitomic-test"
    org false
    creator { FactoryGirl.create(:test_user) }

    factory :imported_project do
      imported_at Time.now
      issues_imported_at Time.now
      labels_imported_at Time.now
    end

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