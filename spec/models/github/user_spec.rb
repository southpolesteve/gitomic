require 'spec_helper'

describe Github::User do
  let(:user) { FactoryGirl.create :test_user }
  let(:project) { FactoryGirl.create :project, creator: user }

  describe '.import' do
    let(:imported_user){ github_user.import(project.owner, project.name) }

    context "a user does not exist" do
      let(:github_user){ FactoryGirl.build(:github_test_user_2) }

      it "should return an new user without a token", :vcr do
        imported_user.github_token.should be_nil
      end

      it "should add the user to the project" do
        github_user.import(project.owner, project.name)
        project.users.should include(imported_user)
      end

    end

    context "a user already exists" do
      let(:github_user){ FactoryGirl.build(:github_test_user) }

      it "should return the existing user", :vcr do
        imported_user.should == user
      end
    end
  end

  describe '#gitomic_user' do
    let(:github_user){ FactoryGirl.build(:github_test_user) }
    let!(:user) { FactoryGirl.create :test_user }

    it "should return a user" do
      github_user.gitomic_user.should == user
    end
  end

end