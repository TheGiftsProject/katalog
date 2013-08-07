require 'spec_helper'

describe Github::RepoSearchResult do

  use_vcr_cassette 'Github_RepoSearchResult/repo_data'

  let(:repo_id) { 11636484 }
  let(:repo_url) { 'https://github.com/iic-ninjas/MyAwesomeKataRepo' }
  let(:repo_name) { 'MyAwesomeKataRepo' }
  let(:description) { 'My Awesome Kata Repo' }
  let(:language) { 'Ruby' }

  let(:repo_data) { load_repo_data }

  def load_repo_data
    result = Octokit::Client.new.search_repositories('@iic-ninjas myawesome')
    result.items.first
  end

  subject { Github::RepoSearchResult.new(repo_data) }

  its(:repo_id) { should eq repo_id }
  its(:repo_url) { should eq repo_url }
  its(:name) { should eq repo_name }
  its(:description) { should eq description }
  its(:language) { should eq language }

end
