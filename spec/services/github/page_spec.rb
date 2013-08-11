require 'rspec'

describe Github::Page do

  let(:page_name) { :readme }

  context "when the project doesn't have a Github repository"  do

    let(:project_without_a_repo) { create(:project, :repo_url => nil) }

    it 'raises an invalid project error' do
      expect {
        Github::Page.new(project_without_a_repo)
      }.to raise_error Github::Page::InvalidProjectError
    end

  end

  context 'when the project has a Github repository' do

    subject { Github::Page.new(project) }

    context "when the project doesn't contain the file" do

      let(:project) { create(:project, :repo_url => 'https://github.com/ikingyoung/Demo') }
      let(:client) { subject.send(:client) }

      before do
        allow(client).to receive(page_name).and_raise Octokit::NotFound
      end

      it 'raises a file not found error' do
        expect {
          subject.send(page_name)
        }.to raise_error Github::Page::FileNotFoundError
      end

    end

    context 'when the project contains the file' do

      let(:repo_url) { Octokit::Repository.new(repo_name).url }
      let(:project) { create(:project, :repo_url => repo_url) }
      let(:actual_page_content) { 'load content from file + VCR' }

      describe 'fetches the file from Github' do

        def load_file(file_name)
          File.read("#{Rails.root}/spec/test_files/#{file_name.upcase}.html").force_encoding("ASCII-8BIT")
        end

        describe :readme do
          let(:repo_name) { 'jashkenas/backbone' }
          it "fetches the project's README.md", :vcr do
            subject.readme.should eq load_file('readme')
          end
        end


        describe :changelog do
          let(:repo_name) { 'pcreux/pimpmychangelog' }
          it "fetches the project's CHANGELOG.md", :vcr do
            subject.changelog.should eq load_file('changelog')
          end
        end

        describe :todo do
          let(:repo_name) { 'socketstream/socketstream' }
          it "fetches the project's TODO.md", :vcr do
            subject.todo.should eq load_file('todo')
          end
        end

      end

    end

  end

end
