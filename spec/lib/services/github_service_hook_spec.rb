require 'spec_helper'

describe GithubServiceHook do

  let(:project) { create(:project, :with_repo) }
  let(:repository_url) { 'some repo url' }
  let(:contributors_email) { 'test.email.com' }
  let(:contributors_emails) { [contributors_email] }
  let(:last_commit_date) { '2013-07-26T00:25:33-07:00' }

  let(:payload) { double(:github_payload,
                         repository_url: repository_url,
                         last_commit_date: last_commit_date,
                         contributors_emails: contributors_emails)
  }

  subject { GithubServiceHook.new(project) }

  before :each do
    subject.with_payload(payload)
    subject.process_payload
  end

  describe :process_payload do

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

    it "updated the project's last commit date from the payload" do
      expect{
        subject.process_payload
      }.to change(project, :last_commite_date).to(last_commit_date)
    end
  end

  describe :sync_contributors do

    context 'when the payload contributors are included in the project' do

      let(:existing_contributor_email) { project.users.first.email }
      let(:contributors_emails) { [existing_contributor_email] }

      it "syncs the project's contributors" do
        expect(project).to have_received(:sync_contributors)
      end
    end

    context 'when the payload contributors are not included in the project' do

      let(:new_contributor_email) { 'new@email.com' }
      let(:contributors_emails) { [new_contributor_email] }

      it "ignore project's contributors sync" do
        expect(project).not_to have_received(:sync_contributors)
      end
    end

  end

end
