require 'spec_helper'

describe Github::Label do
  let(:user) { FactoryGirl.build :test_user }

  describe '.list' do
    use_vcr_cassette
    it "should return all repo labels" do
      labels = Github::Label.list user, "gitomic-test", "gitomic-test"
      labels.should contain_only_instances_of(Github::Label)
    end
  end

end