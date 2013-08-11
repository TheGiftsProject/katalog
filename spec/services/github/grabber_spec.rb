require 'spec_helper'

describe Github::Grabber do

  subject { Github::Grabber.new(project_name) }

  describe 'fetch info on a project' do

    let(:project_name) { 'emberjs/ember-rails' }

    let(:website_url) { 'https://github.com/emberjs/ember-rails' }
    let(:commit_sha1) { '6a90f623cb6c4cfc69e02773c50ccf01bc24439b' }
    let(:commit_message) { "Merge pull request #223 from ccarruitero/readme\n\nadd bootstrap generator options in README" }
    let(:commit_date) { '2013-07-21T11:55:35Z' }

    it "fetches the project's website URL", :vcr do
      subject.website.should eq website_url
    end

    it "fetches the project's last commit", :vcr do
      last_commit = subject.last_commit
      last_commit.sha.should eq commit_sha1
      last_commit.message.should eq commit_message
      last_commit.date.should eq commit_date
    end

  end

  describe :contributors do
    let(:project_name) { 'rspec/rspec' }
    let(:contributor_name) { 'dchelimsky' }
    let(:contributor_avatar_url) { 'https://secure.gravatar.com/avatar/5d38ab152e1e3e219512a9859fcd93af?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png' }

    it "fetches the project's contributors", :vcr do
      contributors = subject.contributors
      contributors.first.login.should eq contributor_name
      contributors.first.avatar_url.should eq contributor_avatar_url
      contributors.should have(7).contributors
    end
  end

  describe 'Github service hooks' do

    let(:project_name) { 'iic-ninjas/MyAwesomeKataRepo' }
    let(:push_events_url) { subject.send(:subscribe_topic) }
    let(:post_callback_url) { 'http://iic-katalog.mock-url.com/callback' }
    let(:client) { subject.send(:client) }

    before do
      Github::Grabber.hook_callback_url = post_callback_url
    end

    it 'subscribes to service hook', :vcr do
      subject.subscribe_to_service_hook.should be_true
    end

    it 'subscribes to service hook with a callback url' do
      allow(client).to receive(:subscribe) { true }
      subject.subscribe_to_service_hook
      expect(client).to have_received(:subscribe).with(push_events_url, post_callback_url)
    end

    it 'unsubscribes from a service hook', :vcr do
      subject.unsubscribe_to_service_hook.should be_true
    end

    it 'unsubscribes from a service hook for the callback url' do
      allow(client).to receive(:unsubscribe) { true }
      subject.unsubscribe_to_service_hook
      expect(client).to have_received(:unsubscribe).with(push_events_url, post_callback_url)
    end

  end

end
