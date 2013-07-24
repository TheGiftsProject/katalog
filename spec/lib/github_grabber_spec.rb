require 'spec_helper'

describe GithubGrabber do

  #let(:project_name) { 'jashkenas/backbone' }

  let(:project_name) { 'socketstream/socketstream' }

  describe 'fetch info files from a project' do

    it "fetches the project's README.md" do

      #subject.readme.should eq 'readme file'

      readme = Octokit.contents 'octokit/octokit.rb', :path => 'README.md', :accept => 'application/vnd.github.html'

      readme.should eq "moshe"


    end

    it "fetches the project's CHANGELOG.md" do

      subject.changelog.should eq 'changelog file'

    end

    it "fetches the project's TODO.md" do

      subject.changelog.should eq 'todo file'

    end

  end


  describe 'fetch info on a project' do

    it "fetches the project's website URL" do

      subject.website_url.should eq 'website url'

    end

    it "fetches the project's last commit" do

      subject.last_commit.should eq 'last_commit'

    end

    it "fetches the project's contributors" do

      subject.contributors.should eq ['contributor#1', 'contributor#2']

    end

  end

end