require 'spec_helper'

describe GithubPayload do

  let(:repository_url) { 'https://github.com/iic-ninjas/MyAwesomeKataRepo' }
  let(:contributors_email) { 'afarhi@ebay.com' }
  let(:last_commit_date) { '2013-07-26T00:25:33-07:00' }
  let(:raw_payload) { load_payload_from_file }

  subject { GithubPayload.new(raw_payload) }

  def load_payload_from_file
    File.read("#{Rails.root}/spec/test_files/payload.json")
  end

  its(:repository_url) { should eq repository_url }
  its(:contributors_emails) { should eq [contributors_email] }
  its(:last_commit_date) { should eq last_commit_date }

end
