require 'spec_helper'
require 'create_project_from_email'

describe CreateProjectFromEmail do
  subject { CreateProjectFromEmail }
  let(:email_sample) { Postmark::Mitt.new(File.read("#{Rails.root}/spec/fixtures/sample_email.json")) }
  context "email from an authorized user" do
    let!(:authorized_user) { create(:user, email: "authorized@user.com") }
    let(:title) { email_sample.subject }
    let(:subtitle) { email_sample.text_body.split("\n").first }
    let(:post_text) { email_sample.text_body.split("\n").drop(1).join("\n") }
    it "should create project" do
      expect {
        subject.create(email_sample)
      }.to change { authorized_user.projects.count }.by(1)
    end

    it "should create project to the user with correct project details" do 
      project = subject.create(email_sample)
      project.title.should == title
      project.subtitle.should == subtitle
      project.posts.count.should == 1
      project.posts.first.text.should == post_text
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
