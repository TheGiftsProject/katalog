require 'spec_helper'

describe Project::GithubConcern do

  let(:user) { create(:user, :isc_ci) }

  let(:github_grabber) { subject.send(:github_grabber) }

  subject { create(:project, :with_repo, users: [user]) }

end
