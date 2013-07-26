require 'spec_helper'

describe GithubServiceHook do

  let(:project) { create(:project) }

  let(:payload) { load_payload_from_file }

  subject { GithubServiceHook.new(payload) }

  def load_payload_from_file
    File.read("#{Rails.root}/spec/test_files/payload.json")
  end

  describe :process_payload do

    before :each do
      subject.process_payload
    end

    context 'when on master branch' do

      context 'when the payload has a matching project' do

        it "syncs the project's last commit date"
        it "syncs the project's contributors"

      end

    end

  end


end
