require 'spec_helper'

describe GithubPagesController do

  let(:current_project) { create(:project, :with_repo) }

  before do
    allow(controller).to receive(:current_project).and_return(current_project)
  end

  shared_examples :github_page do

    let(:page_name) { example.example_group.parent.description }
    let(:action_name) { "github_#{page_name}".to_sym }

    let(:page_content) { "#{page_name}-html-content" }

    before do
      allow(current_project).to receive(action_name).and_return(page_content)
      get page_name, :project_id => current_project.id
    end

    it "fetchs the file from Github" do
      expect(assigns[:github_page]).to eq page_content
    end

    it 'sets the page title to be the current action' do
      expect(assigns[:github_page_title]).to eq action_name.to_s
    end

  end


  GithubPagesController::GITHUB_PAGES.each do |github_page_name|

    describe github_page_name do
      it_behaves_like :github_page
    end

  end

end
