require 'spec_helper'

describe Github::RepoSeachResult do

  let(:name) { 'repository_name' }
  let(:description) { 'repository_description' }
  let(:language) { 'repository_language' }

  subject { Github::RepoSeachResult.new(raw_json) }

  its(:name) { should eq repository_name }
  its(:description) { should eq repository_description }
  its(:language) { should eq repository_language }

end
