require 'spec_helper'

describe GithubSyncer do

  let(:user) { create(:user, :isc_ci) }
  let(:project) { create(:project, :with_repo, users: [user]) }
  let(:github_grabber) { subject.send(:github_grabber) }

  subject { GithubSyncer.new(project) }

  describe :sync do

    context 'when sync with Github is needed' do

      before do
        allow(subject).to receive(:should_sync?).and_return(true)
        allow(github_grabber).to receive(:subscribe_to_service_hook)
        allow(subject).to receive(:sync_demo_url)
        allow(subject).to receive(:sync_last_commit_date)
        allow(subject).to receive(:sync_contributors)
        subject.sync
      end

      it "subscribes to service hook" do
        expect(github_grabber).to have_received(:subscribe_to_service_hook)
      end

      it "syncs the project's demo url" do
        expect(subject).to have_received(:sync_demo_url)
      end

      it "syncs the project's last commit date"do
        expect(subject).to have_received(:sync_last_commit_date)
      end

      it "syncs the project's contributors"do
        expect(subject).to have_received(:sync_contributors)
      end

    end

  end

  describe :sync_demo_url do

    let(:demo_url) { 'http://my-repo.demo.com' }

    before do
      allow(github_grabber).to receive(:website).and_return(demo_url)
    end

    it "sets the project's demo url" do
      expect{
        subject.sync_demo_url
      }.to change(project, :demo_url).to(demo_url)
    end

  end

  describe :sync_last_commit_date do

    let(:last_commit_date) {  3.days.ago }
    let(:last_commit) { double(:last_commit, date: last_commit_date) }

    before do
      allow(github_grabber).to receive(:last_commit).and_return(last_commit)
    end

    it "sets the project's last commit date" do
      expect{
        subject.sync_last_commit_date
      }.to change(project, :last_commit_date).to(last_commit_date)
    end

  end

  describe :sync_contributors do

    context "when the project's contributors are all in sync" do

      let(:existing_user) { create(:github_contributor, id: user.uid) }

      before do
        allow(subject).to receive(:contributors).and_return([existing_user])
      end

      it "doesn't add any new users" do
        expect {
          subject.sync_contributors
        }.to_not change(project.users, :count)
      end

    end

    context "when the project's contributors are not in sync" do

      let(:new_user) { create(:github_contributor) }

      before do
        allow(subject).to receive(:contributors).and_return([new_user])
      end

      it 'adds the new contributor to the project' do
        expect {
          subject.sync_contributors
        }.to change(project.users, :count).by(1)
      end

    end

  end


end
