require 'spec_helper'

describe Github::RepoSearcher do

  let(:given_query) { 'myawesome' }
  let(:search_query) { subject.send(:search_query) }

  subject { Github::RepoSearcher.new }

  describe :search do

    before do
      allow(subject).to receive(:search_results)
      allow(subject).to receive(:valid_results?)
    end

    it 'searches for Github repositories the results' do
      subject.search(given_query)
      expect(subject).to have_received(:search_results)
    end

    it 'validates the results' do
      subject.search(given_query)
      expect(subject).to have_received(:valid_results?)
    end

    context 'when the results are valid' do

      before do
        allow(subject).to receive(:valid_results?).and_return(true)
        allow(subject).to receive(:parse_results)
      end

      it 'parses the result items' do
        subject.search(given_query)
        expect(subject).to have_received(:parse_results)
      end
    end

    context 'when the results are invalid' do

      before do
        allow(subject).to receive(:valid_results?).and_return(false)
      end

      it 'returns an empty result' do
        subject.search(given_query).should be_empty
      end
    end

  end

  describe :search_results do

    let(:github_client) { subject.send(:github_client) }
    let(:search_options){ subject.send(:search_options) }

    it "searches for Github repositories using Github's API", :vcr do
      subject.query = given_query
      results = subject.send(:search_results)
      results.items.should have(1).item
    end

    it "searches for Github repositories with the given query and the default search options" do
      allow(github_client).to receive(:search_repositories).with(search_query, search_options)
      subject.send(:search_results)
      expect(github_client).to have_received(:search_repositories).with(search_query, search_options)
    end

    describe 'search setup' do
      let(:organization_filter){ subject.class.organization_filter }

      it "limits the search to the #{Github::RepoSearcher::GITHUB_ORGANIZATION_NAME} organization" do
        search_query.should include organization_filter
      end

      it "limits the number of search results to #{Github::RepoSearcher::SEARCH_RESULTS_LIMIT}" do
        search_options[:per_page].should eq Github::RepoSearcher::SEARCH_RESULTS_LIMIT
      end

    end

  end

  describe :valid_results? do

    let(:search_results) { double('MockSearchResults', :total_count => number_of_results) }
    let(:valid_results?) { subject.send(:valid_results?) }

    before do
      allow(subject).to receive(:search_results).and_return(search_results)
    end

    context 'when the result contains matching repositories' do
      let(:number_of_results) { 1 }
      it 'is valid' do
        valid_results?.should be_true
      end
    end

    context 'when the response has no items' do
      let(:number_of_results) { 0 }
      it 'is invalid' do
        valid_results?.should be_false
      end
    end

  end

  describe :parse do

    let(:parsed_results) { subject.send(:parse_results) }
    let(:repo_name) { 'MyAwesomeKataRepo' }

    before do
      subject.query = given_query
      subject.send(:search_results)
    end

    it 'creates an array of respo search results for the search response items', :vcr do
      parsed_results.should have(1).item
      repo_result = parsed_results.first
      repo_result.should be_an_instance_of(Github::RepoSearchResult)
      repo_result.name.should eq repo_name
    end

  end

end
