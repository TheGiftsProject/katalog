require 'spec_helper'

describe UserGithubConcern do

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
      let(:avatar_url) { 'http://some-avatar.url.com' }
      let(:new_contributor) { create(:github_contributor, id: uid, login: login, avatar_url: avatar_url) }

      let(:github_contributor) { new_contributor }

      it 'initializes a new user from the new contributor' do
        subject.should be_new_record
      end

      its(:uid){ should eq uid }
      its(:name){ should eq login }
      its(:nickname){ should eq login }
      its(:image){ should eq avatar_url }

    end

  end

end
