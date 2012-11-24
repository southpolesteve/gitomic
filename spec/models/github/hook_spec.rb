require 'spec_helper'

describe Github::Hook do

  describe '.create' do
    use_vcr_cassette
    let(:project) { FactoryGirl.build :project }
    subject { Github::Hook.create project.creator, project.owner, project.name }

    it { should be_instance_of(Github::Hook) }
    it { subject.id.should_not be_nil }
  end

end