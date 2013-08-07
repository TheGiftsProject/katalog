require 'spec_helper'

describe GithubHookController do

  describe :post_receive_hook do

    let(:current_project) { create(:project, :with_repo) }
    let(:raw_payload) { load_payload_from_file }
    let(:payload) { Github::Payload.new(raw_payload) }
    let(:github_service) { controller.send(:github_service) }

    def load_payload_from_file
      File.read("#{Rails.root}/spec/test_files/payload.json")
    end

    before do
      #make sure things don't get messy
      allow_any_instance_of(Github::ServiceHook).to receive(:process_payload)
    end

    it 'parses the payload' do
      allow(Github::Payload).to receive(:new).with(raw_payload).and_call_original
      post :post_receive_hook, :project_id => current_project.id, :payload => raw_payload
      expect(Github::Payload).to have_received(:new).with(raw_payload)
    end

    it 'processes the given post receive payload' do
      allow(controller).to receive(:payload).and_return(payload)
      allow(Github::ServiceHook).to receive(:new).with(current_project).and_call_original

      post :post_receive_hook, :project_id => current_project.id, :payload => raw_payload

      expect(Github::ServiceHook).to have_received(:new).with(current_project)
      expect(github_service).to have_received(:process_payload).with(payload)
    end

  end

end
