require 'spec_helper'

describe Project::GithubConcern do

  let(:user) { create(:user, :isc_ci) }

  let(:github_grabber) { subject.send(:github_grabber) }

  subject { create(:project, :with_repo, users: [user]) }

  describe :sync_with_github do

    context 'when sync with Github is needed' do

      before do
        subject.stub(:should_sync_with_github? => true)
        allow(subject).to receive(:subscribe_to_service_hook)
        allow(subject).to receive(:sync_website_url)
        allow(subject).to receive(:sync_last_commit_date)
        allow(subject).to receive(:sync_contributors)
        subject.sync_with_github
      end

      it "subscribes to service hook" do
        expect(subject).to have_received(:subscribe_to_service_hook)
      end

      it "syncs the project's website" do
        expect(subject).to have_received(:sync_website_url)
      end

      it "syncs the project's last commit date"do
        expect(subject).to have_received(:sync_last_commit_date)
      end

      it "syncs the project's contributors"do
        expect(subject).to have_received(:sync_contributors)
      end

    end

  end

  describe :subscribe_to_service_hook do

    it "subscribes to service hook" do
      allow(github_grabber).to receive(:subscribe_to_service_hook)
      subject.subscribe_to_service_hook
      expect(github_grabber).to have_received(:subscribe_to_service_hook)
    end
  end

  describe :sync_website_url do

    let(:website_url) { 'http://my-repo.website.com' }

    before do
      allow(github_grabber).to receive(:website).and_return(website_url)
    end

    it "sets the project's website" do
      expect{
        subject.sync_website_url
      }.to change(subject, :website_url).to(website_url)
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
      }.to change(subject, :last_commit_date).to(last_commit_date)
    end

  end



  describe :sync_contributors do

    context "when the project's contributors are all in sync" do

      let(:existing_user) {
        Hashie::Mash.new(
            id: user.uid,
            login: user.nickname,
            avatar_url: user.image
        )
      }

      before do
        subject.stub(:contributors => [existing_user])
      end

      it "doesn't add any new users" do
        expect {
          subject.sync_contributors
        }.to_not change(subject.users, :count)
      end

    end

    context "when the project's contributors are not in sync" do

      let(:uid) { '1232333' }
      let(:nickname) { 'new-user-nickname' }
      let(:avatar_url) { 'http://new-user.avatar-url.com' }

      let(:new_user) {
        Hashie::Mash.new(
          id: uid,
          login: nickname,
          avatar_url: avatar_url
        )
      }

      before do
        subject.stub(:contributors => [new_user])
      end

      it 'adds the new contributor to the project' do
        expect {
          subject.sync_contributors
        }.to change(subject.users, :count).by(1)

        User.last.projects.should include subject
        subject.reload.users.should include User.last
      end

    end

  end

end
