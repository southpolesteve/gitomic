require 'spec_helper'

describe Project do
  let(:project){ FactoryGirl.create(:project) }

  describe '.import_labels' do

    it "should import and save all repo labels" do
      pending "WIP"
      project.import_labels
      project.labels.should have_at_least(1).items
      project.labels.map(&:persisted?).uniq.should be_true
    end

    it "should update the labels imported time" do
      project.labels_imported_at.should_not be_nil
    end

  end

  describe '.import_team' do
    context 'for a user repo' do
      it "pending"
    end

    context 'for a org repo' do
      it "pending"
    end
  end

  describe '.import_issues' do
    it "pending"
  end

end