require 'spec_helper'

describe GithubGrabber do

  subject { GithubGrabber.new(project_name) }

  describe 'fetch info files from a project' do

    def load_file(file_name)
      File.read("#{Rails.root}/spec/test_files/#{file_name.upcase}.md").force_encoding("ASCII-8BIT")
    end

    describe :readme do
      let(:project_name) { 'jashkenas/backbone' }
      it "fetches the project's README.md", :vcr do
        subject.readme.should eq load_file('readme')
      end
    end

    describe :changelog do
      let(:project_name) { 'pcreux/pimpmychangelog' }
      it "fetches the project's CHANGELOG.md", :vcr do
        subject.changelog.should eq load_file('changelog')
      end
    end

    describe :todo do
      let(:project_name) { 'socketstream/socketstream' }
      it "fetches the project's TODO.md", :vcr do
        subject.todo.should eq load_file('todo')
      end
    end

  end

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

end
