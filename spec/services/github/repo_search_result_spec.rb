require 'spec_helper'

describe Github::RepoSearchResult do

  let(:repo_url) { 'https://github.com/iic-ninjas/MyAwesomeKataRepo' }
  let(:name) { 'repository_name' }
  let(:owner) { 'repository_owner' }
  let(:description) { 'repository_description' }
  let(:language) { 'repository_language' }

  subject { Github::RepoSearchResult.new(raw_json) }

  its(:repo_url) { should eq repo_url }
  its(:name) { should eq name }
  its(:name) { should eq owner }
  its(:description) { should eq description }
  its(:language) { should eq language }

end
