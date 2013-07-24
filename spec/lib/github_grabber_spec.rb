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

    let(:project_name) { 'ebryn/ember-model' }

    it "fetches the project's website URL" do

      #subject.repository.should eq 'website url'

    end

    xit "fetches the project's last commit" do

      #subject.last_commit.should eq 'last_commit'

    end

    xit "fetches the project's contributors" do

      #subject.contributors.should eq ['contributor#1', 'contributor#2']

    end

  end

end