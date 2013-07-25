require 'spec_helper'

describe Project do

  subject { create(:project) }

  describe :sync_with_github do

    it "sets the project's website"
    it "sets the project's last commit date"
    it "sets the project's contributors"

  end

end