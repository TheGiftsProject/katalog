require 'spec_helper'

describe GithubServiceHook do

  let(:project) { create(:project) }

  let(:payload) { GithubPayload.new(raw_payload) }

  subject { GithubServiceHook.new(project) }

  before :each do
    subject.with_payload(payload)
    subject.process_payload
  end

  describe :process_payload do

    context 'when the payload has a matching project' do

      before :all do
        subject.stub(:has_matching_project? => true)
      end

      it "syncs the project's last commit date" do
        expect(subject).to have_received(:sync_last_commit)
      end

      it "syncs the project's contributors" do
        expect(subject).to have_received(:sync_contributors)
      end

    end

    context 'when the payload has no matching project' do

      before :all do
        subject.stub(:has_matching_project? => false)
      end

      it "ignore project's last commit date sync" do
        expect(subject).not_to have_received(:sync_last_commit)
      end

      it "ignore project's contributors sync" do
        expect(subject).not_to have_received(:sync_contributors)
      end

    end

  end

  describe :sync_last_commit do

    let(:new_date) { DateTime.new }

    let(:payload_with_new_date) { }
    let(:payload) { payload_with_new_date }

    it "updated the project's last commit date from the payload" do
      expect{
        subject.process_payload
      }.to change(project, :last_commite_date).to(new_date)
    end
  end

  describe :sync_contributors do

    context 'when the payload contributors are included in the project' do

      let(:payload_with_existing_contributors) { }
      let(:payload) { payload_with_existing_contributors }

      it "syncs the project's contributors" do
        expect(project).to have_received(:sync_contributors)
      end
    end

    context 'when the payload contributors are not included in the project' do

      let(:payload_with_new_contributors) { }
      let(:payload) { payload_with_new_contributors }

      it "ignore project's contributors sync" do
        expect(project).not_to have_received(:sync_contributors)
      end
    end

  end

end
