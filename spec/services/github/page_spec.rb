require 'rspec'

describe Github::Page do

  subject { Github::Page.new(project) }

  let(:page_name) { :readme }
  #let(:page_name) { example.example_group.parent.description }

  context "when the project doesn't have a Github repository"  do

    let(:project) { create(:project, :repo_url => nil) }

    it 'raises an invalid project error' do
      expect {

      }.to raise_error Github::Page::InvalidProjectError
    end

  end

  context 'when the project has a Github repository' do

    let(:project) { create(:project, :with_repo) }

    context "when the project doesn't contain the file" do

      before do
        allow(subject).to receive(page_name).and_return(nil)
      end

      it 'raises a file not found error' do
        expect {
          subject.send(page_name)
        }.to raise_error Github::Page::FileNotFoundError
      end

    end

    context 'when the project contains the file' do

      let(:actual_page_content) { 'load content from file + VCR' }

      it 'fetches the file from Github' do

        github_page_content = subject.send(page_name)
        expect(github_page_content).to eq actual_page_content

      end

    end

  end

end
