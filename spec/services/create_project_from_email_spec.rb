require 'spec_helper'
require 'create_project_from_email'

describe CreateProjectFromEmail do
  subject { CreateProjectFromEmail }
  let(:email_sample) { Postmark::Mitt.new(File.read("#{Rails.root}/spec/fixtures/sample_email.json")) }
  context "email from an authorized user" do
    let!(:authorized_user) { create(:user, email: "authorized@user.com") }
    it "should create project" do
      expect {
        subject.create(email_sample)
      }.to change { Project.count }.by(1)
    end

    it "should create project with correct title and subtitle" do
      project = subject.create(email_sample)
      project.title.should == email_sample.subject
      project.subtitle.should == email_sample.text_body
    end
  end

  context "email from an unauthorized email" do
    let!(:unauthorized_user) { create(:user, email: "unauthorized@user.com") }
    it "should not create a project" do
      expect {
        subject.create(email_sample)
      }.to_not change { Project.count }
    end
  end

end
