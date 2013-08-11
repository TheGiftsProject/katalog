require 'spec_helper'

describe GithubPagesController do

  let(:current_project) { create(:project, :with_repo) }

  before do
    allow(controller).to receive(:current_project).and_return(current_project)
  end

  shared_examples :github_page do

    let(:page_name) { example.example_group.parent.description }
    let(:action_name) { "github_#{page_name}".to_sym }

    let(:page_title) { page_name.to_s }
    let(:page_content) { "#{page_name}-html-content" }

    before do
      allow(current_project).to receive(action_name).and_return(page_content)
      get page_name, :project_id => current_project.id
    end

    context "when the project doesn't have a Github repository"  do

      it 'redircts back to project page'

    end

    context 'when the project has a Github repository' do

      context "when the project doesn't contain the file" do

        it "shows a notice that the page doesn't exists yet"

      end

      context 'when the project contains the file' do

        it "fetchs the file from Github" do
          expect(assigns[:github_page]).to eq page_content
        end

        it 'sets the page title to be the current action' do
          expect(assigns[:github_page_title]).to eq page_title
        end

      end
    end

  end


  GithubPagesController::GITHUB_PAGES.each do |github_page_name|

    describe github_page_name do
      it_behaves_like :github_page
    end

  end

end
