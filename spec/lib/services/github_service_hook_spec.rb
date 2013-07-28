require 'spec_helper'

describe GithubServiceHook do

  let(:project) { create(:project) }

  let(:raw_payload) { load_payload_from_file }

  subject { GithubServiceHook.new(project) }

  def load_payload_from_file
    File.read("#{Rails.root}/spec/test_files/payload.json")
  end

  describe :process_payload do

    before :each do
      subject.process_payload(raw_payload)
    end

    context 'when the payload has a matching project' do

      before :all do
        subject.stub(:has_matching_project? => true)
      end

      it "syncs the project's last commit date" do
        expect(subject).to have_received(:sync_last_commit)
      end

      it "syncs the project's contributors" do
        expect(subject).to have_received(:sync_contributors)
      end

    end

    context 'when the payload has no matching project' do

      before :all do
        subject.stub(:has_matching_project? => false)
      end

      it "ignore project's last commit date sync" do
        expect(subject).not_to have_received(:sync_last_commit)
      end

      it "ignore project's contributors sync" do
        expect(subject).not_to have_received(:sync_contributors)
      end

    end

  end

  describe :sync_last_commit do

    let(:new_date) { DateTime.new }

    before :each do
      # stub date with new date
    end

    it "updated the project's last commit date from the payload" do
      expect{
        subject.process_payload(raw_payload)
      }.to change(project, :last_commite_date).to(new_date)
    end
  end

  describe :sync_contributors do

    context 'when the payload contributors are included in the project' do

      let(:raw_payload_with_existing_contributors) { }
      before :each do
        subject.process_payload(raw_payload_with_existing_contributors)
      end
      it "syncs the project's contributors" do
        expect(project).to have_received(:sync_contributors)
      end
    end

    context 'when the payload contributors are not included in the project' do
      let(:raw_payload_with_new_contributors) { }
      before :each do
        subject.process_payload(raw_payload_with_new_contributors)
      end
      it "ignore project's contributors sync" do
        expect(project).not_to have_received(:sync_contributors)
      end
    end

  end


end
