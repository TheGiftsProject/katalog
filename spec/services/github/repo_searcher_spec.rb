require 'spec_helper'

describe Github::RepoSearcher do

  let(:given_query) { 'myawesome' }
  let(:search_query) { subject.send(:search_query) }
  let(:search_results) {}

  subject { Github::RepoSearcher.new(given_query) }

  describe :search do

    let(:github_client) { subject.send(:github_client) }
    let(:search_options) { subject.class.search_options }
    let(:raw_search_results) { 'raw_search_results' }

    it "searches for Github repositories using Github's API" do
      allow(github_client).to receive(:search_repositories).with(given_query, search_options)
      expect(github_client).to have_received(:search_repositories).with(given_query, search_options)
    end

    it 'validates the results' do
      expect(subject).to have_received(:validate_results)
    end

    context 'when the results are valid' do
      it 'parses the result items'
    end

    context 'when the results are invalid' do
      it 'returns an empty result'
    end


  end

  describe :search_results do

    let(:github_client) { subject.send(:github_client) }
    let(:search_options) { subject.class.search_options }
    let(:raw_search_results) { 'raw_search_results' }

    it "searches for Github repositories using Github's API", :vcr do
      subject.send(:search_results).total_count.should eq 1
    end

    it "searches for Github from the given query with the default search options" do
      allow(github_client).to receive(:search_repositories).with(search_query, search_options)
      subject.send(:search_results)
      expect(github_client).to have_received(:search_repositories).with(search_query, search_options)
    end

    describe 'search setup', :focus do
      let(:organization_filter){ subject.class.organization_filter }
      let(:search_options){ subject.class.search_options }

      it "limits the search to the #{Github::RepoSearcher::GITHUB_ORGANIZATION_NAME} organization" do
        search_query.should include organization_filter
      end

      it "limits the number of search results to #{Github::RepoSearcher::SEARCH_RESULTS_LIMIT}" do
        search_options[:per_page].should eq Github::RepoSearcher::SEARCH_RESULTS_LIMIT
      end
      
    end

  end

  describe :validate_results do

    context 'when the result contains matching repositories' do
      it 'is valid'
    end

    context 'when the response has no items' do
      it 'is invalid'
    end

  end

  describe :parse do

    let(:max_search_limit) { Github::RepoSearcher::SEARCH_RESULTS_LIMIT }

    let(:parsed_results) { subject.send(:parse_results) }

    it 'creates an array of respo search results for the search response items' do
      expect(parsed_results).to include do |repo_result|
        repo_result.should be_an_instance_of(Github::RepoSearchResult)
      end
    end

  end

end
