require 'spec_helper'

describe Project do
  let(:user){ FactoryGirl.create(:test_user) }
  let(:project){ FactoryGirl.create(:project, creator: user) }

  describe '.import_labels' do
    before { project.import_labels }
    
    it "should import and save all repo labels", :vcr do
      project.labels.should have_at_least(1).items
      project.labels.should all_be_persisted
    end

    it "should update the labels imported time", :vcr do
      project.labels_imported_at.should_not be_nil
    end

  end

  describe '.import_team' do
    context 'for a user repo' do
      before { project.import_team }

      it "pending"
    end 

    context 'for a org repo' do
      before { project.import_team }

      it "pending"
    end
  end

  describe '.import_issues' do
    before { project.import_issues }

    it "pending"
  end

end