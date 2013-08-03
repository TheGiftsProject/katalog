require 'spec_helper'

describe Github::RepoSearcher do

  let(:given_query) { 'katalog' }
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

  describe :search_results, :focus do

    let(:github_client) { subject.send(:github_client) }
    #let(:search_options) { subject.class.search_options }
    let(:raw_search_results) { 'raw_search_results' }

    it "searches for Github repositories using Github's API", :vcr do
      subject.send(:search_results).count.should eq 1
    end


    #it "searches for Github from the given query with the default search options" do
    #  allow(github_client).to receive(:search_repositories).with(given_query, search_options)
    #  subject.seach(:search_results)
    #  expect(github_client).to have_received(:search_repositories).with(given_query, search_options)
    #end

    #describe :search_options do
    #  let(:organization_filter){ subject.class.organization_filter }
    #  subject { subject.class.search_options }
    #
    #  it 'limits the search to our organization' do
    #    should include organization_filter
    #  end
    #end

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

    it "limits the search results array to #{Github::RepoSearcher::SEARCH_RESULTS_LIMIT}" do
      expect(parsed_results).to have_at_most(max_search_limit).results
    end

  end

end
