require 'spec_helper'

describe Github::ServiceHook do

  let(:repository_url) { 'some repo url' }
  let(:contributors_email) { 'test.email.com' }
  let(:contributors_emails) { [contributors_email] }
  let(:old_commit_date) { 3.day.ago }
  let(:last_commit_date) { 1.day.ago }

  let(:project) { create(:project, :with_repo, users_count: 1, last_commit_date: old_commit_date) }
  let(:user) { project.users.first }

  let(:payload) { double(:github_payload,
                         repository_url: repository_url,
                         last_commit_date: last_commit_date,
                         contributors_emails: contributors_emails)
  }

  subject { Github::ServiceHook.new(project) }

  describe :process_payload do

    before :each do
      allow(subject).to receive(:sync_last_commit)
      allow(subject).to receive(:sync_contributors)
      subject.process_payload(payload)
    end

    context 'when the payload has a matching project' do

      let(:repository_url) { project.repo_url }

      it "syncs the project's last commit date" do
        expect(subject).to have_received(:sync_last_commit)
      end

      it "syncs the project's contributors" do
        expect(subject).to have_received(:sync_contributors)
      end

    end

    context 'when the payload has no matching project' do

      let(:repository_url) { 'https://github.com/unknown/repo' }

      it "ignore project's last commit date sync" do
        expect(subject).not_to have_received(:sync_last_commit)
      end

      it "ignore project's contributors sync" do
        expect(subject).not_to have_received(:sync_contributors)
      end

    end

  end

  describe :sync_last_commit do

    before do
      subject.payload = payload
    end

    it "updated the project's last commit date from the payload" do
      expect{
        subject.send(:sync_last_commit)
      }.to change(project, :last_commit_date).from(old_commit_date).to(last_commit_date)
    end

  end

  describe :sync_contributors do

    let(:github_syncer) { subject.send(:github_syncer) }

    before :each do
      subject.payload = payload
      allow(github_syncer).to receive(:sync_contributors)
      subject.send(:sync_contributors)
    end

    context 'when the payload contributors are included in the project' do

      let(:contributors_emails) { [user.email] }

      it "ignore project's contributors sync" do
        expect(github_syncer).not_to have_received(:sync_contributors)
      end
    end

    context 'when the payload contributors are not included in the project' do

      let(:contributors_emails) { ['new_contributor@email.com'] }

      it "syncs the project's contributors" do
        expect(github_syncer).to have_received(:sync_contributors)
      end
    end

  end

end
