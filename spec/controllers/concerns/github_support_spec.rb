require 'spec_helper'

describe 'GithubSupport', :controller do

  controller do
    include GithubSupport

    def index
      @hook_callback_url = Github::Grabber.hook_callback_url
      render :nothing => true
    end
  end

  let(:current_project) { create(:project) }
  let(:hook_callback_url) { project_post_receive_hook_url(current_project) }

  describe :set_github_grabber_host do

    before do
      allow(controller).to receive(:current_project).and_return(current_project)
    end

    it "sets Github's service hook callback url before any action" do
      get :index
      expect(assigns[:hook_callback_url]).to eq hook_callback_url
    end

  end

end
