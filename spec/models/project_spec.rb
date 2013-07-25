require 'spec_helper'

describe Project do

  subject { create(:project) }

  describe :sync_with_github do

    it "syncs the project's website" do
      allow(subject).to receive(:sync_website_url)
      subject.sync_with_github
      expect(subject).to have_received(:sync_website_url)
    end
    it "syncs the project's last commit date"
    it "syncs the project's contributors"



    it "sets the project's website"
    it "sets the project's last commit date"
    it "sets the project's contributors"

  end

end