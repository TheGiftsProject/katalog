require 'spec_helper'

describe User::GithubConcern do

  let(:user) { create(:user, :isc_ci) }

  describe :find_or_init_by_contributor do

    subject { User.find_or_init_by_contributor(github_contributor) }

    context "when contributor is already exists" do

      let(:existing_contributor) { create(:github_contributor, id: user.uid) }
      let(:github_contributor) { existing_contributor }

      it "returns the existing user" do
        subject.should eq user
      end

    end

    context "when contributor is new" do

      let(:uid) { '1234563' }
      let(:login) { 'my-new-user-login' }
      let(:gravatar_id) { '5d38ab152e1e3e219512a9859fcd93af' }
      let(:new_contributor) { create(:github_contributor, id: uid, login: login, gravatar_id: gravatar_id) }

      let(:github_contributor) { new_contributor }

      it 'initializes a new user from the new contributor' do
        subject.should be_new_record
      end

      its(:uid){ should eq uid }
      its(:name){ should eq login }
      its(:nickname){ should eq login }
      its(:gravatar_id){ should eq gravatar_id }
      its(:image){ should eq subject.gravatar }

    end

  end

end
