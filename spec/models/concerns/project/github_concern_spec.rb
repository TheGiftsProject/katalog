require 'spec_helper'

describe Project::GithubConcern do

  describe :includes_contributors? do

    let(:users) { create_list(:user, 2) }
    let(:existing_user_emails) { users.map(&:email) }
    let(:new_contributor_emails) { ['new_contributor1@email.com','new_contributor2@email.com'] }
    let(:project) { create(:project, users: users) }
    subject { project.includes_contributors?(given_user_emails) }

    context "when given emails for users who are contributors in the project" do
      let(:given_user_emails) { existing_user_emails }
      it { should be_true }
    end

    context "when given emails for users who aren't contributors in the project" do
      let(:given_user_emails) { new_contributor_emails }
      it { should be_false }
    end

    context "when given emails for users who some are and some aren't contributors in the project" do
      let(:given_user_emails) { new_contributor_emails + existing_user_emails }
      it { should be_false }
    end

  end

end
