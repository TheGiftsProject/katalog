require 'spec_helper'

describe Github::RepoSeachResult do

  let(:repo_id) { '123456' }
  let(:repo_url) { 'https://github.com/iic-ninjas/MyAwesomeKataRepo' }
  let(:name) { 'repository_name' }
  let(:description) { 'repository_description' }
  let(:language) { 'repository_language' }

  subject { Github::RepoSeachResult.new(raw_json) }

  its(:repo_id) { should eq repo_id }
  its(:repo_url) { should eq repo_url }
  its(:name) { should eq name }
  its(:description) { should eq description }
  its(:language) { should eq language }

end
