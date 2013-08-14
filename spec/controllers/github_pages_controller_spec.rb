require 'spec_helper'

describe GithubPagesController do

  let(:current_project) { create(:project, :with_repo) }

  before do
    allow(controller).to receive(:current_project).and_return(current_project)
  end

  shared_examples :github_page do |page_name|

    let(:action_name) { "github_#{page_name}".to_sym }
    let(:page_title) { page_name.to_s }
    let(:page_content) { "#{page_name}-html-content" }

    context "when the project doesn't have a Github repository"  do

      before do
        allow(subject).to receive(:github_page).and_raise Github::Page::InvalidProjectError
      end

      it 'redircts back to project page' do
        get page_name, :project_id => current_project.id
        expect(response).to redirect_to( project_path(current_project) )
      end

    end

    context 'when the project has a Github repository' do

      let(:github_page) { double(:github_page) }

      before do
        allow(subject).to receive(:github_page).and_return(github_page)
      end

      context "when the project doesn't contain the file" do

        before do
          allow(github_page).to receive(page_name).and_raise Github::Page::FileNotFoundError
        end

        it "shows a notice that the page doesn't exists yet" do
          get page_name, :project_id => current_project.id
          expect(response).to render_template('projects/github_page_not_found')
        end

      end

      context 'when the project contains the file' do

        before do
          allow(github_page).to receive(page_name).and_return(page_content)
          get page_name, :project_id => current_project.id
        end

        it "fetchs the file from Github" do
          expect(assigns[:github_page_content]).to eq page_content
        end

        it 'sets the page title to be the current action' do
          expect(assigns[:github_page_title]).to eq page_title
        end

        it 'shows a the Github page' do
          expect(response).to render_template('projects/github_page')
        end

      end

    end

  end

  GithubPagesController::GITHUB_PAGES.each do |github_page_name|

    describe github_page_name do
      it_behaves_like :github_page, github_page_name
    end

  end

end
