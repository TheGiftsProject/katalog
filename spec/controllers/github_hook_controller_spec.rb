require 'spec_helper'

describe GithubHookController do

  describe :post_receive_hook do

    let(:current_project) { create(:project, :with_repo) }
    let(:raw_payload) { load_payload_from_file }
    let(:payload) { GithubPayload.new(raw_payload) }
    let(:github_service) { controller.send(:github_service) }

    def load_payload_from_file
      File.read("#{Rails.root}/spec/test_files/payload.json")
    end

    before do
      #make sure things don't get messy
      allow_any_instance_of(GithubServiceHook).to receive(:process_payload)
    end

    it 'parses the payload' do
      allow(GithubPayload).to receive(:new).with(raw_payload).and_call_original
      post :post_receive_hook, :project_id => current_project.id, :payload => raw_payload
      expect(GithubPayload).to have_received(:new).with(raw_payload)
    end

    it 'processes the given post receive payload' do
      allow(controller).to receive(:payload).and_return(payload)
      allow(GithubServiceHook).to receive(:new).with(current_project).and_call_original

      post :post_receive_hook, :project_id => current_project.id, :payload => raw_payload

      expect(GithubServiceHook).to have_received(:new).with(current_project)
      expect(github_service).to have_received(:process_payload).with(payload)
    end

  end

end
