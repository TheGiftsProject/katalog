require 'spec_helper'

describe GithubPagesController do

  let(:current_project) { create(:project, :with_repo) }

  describe :read do

    let(:page_content) { 'readme' }

    before do
      allow_any_instance_of(GithubGrabber).to receive(:readme).and_return(page_content)
      get :readme, :project_id => current_project.id
    end

    it 'fetchs the readme file from Github' do
      expect(assigns[:github_page]).to eq page_content
    end

    it 'sets the page title to be the current action' do
      expect(assigns[:github_page_title]).to eq "README"
    end

  end

end
