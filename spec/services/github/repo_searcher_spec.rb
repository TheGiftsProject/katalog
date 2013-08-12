require 'spec_helper'

describe Github::RepoSearcher do

  let(:given_query) { 'myawesome' }
  let(:search_query) { subject.send(:search_query) }

  subject { Github::RepoSearcher.new }

  describe :latest do

    before do
      allow(subject).to receive(:perform_search)
    end

    let(:latest_search_options) { subject.class.send(:latest_search_options) }
    let(:search_options) { subject.send(:search_options) }

    it 'sets the search options to the latest search options' do
      subject.latest
      expect(search_options).to eq latest_search_options
    end

    it 'sets an empty search query to load all the latest repos' do
      allow(subject).to receive(:perform_search)
      subject.latest
      expect(subject.query).to be_blank
    end

  end

  describe :search do

    before do
      allow(subject).to receive(:perform_search)
      allow(subject).to receive(:valid_results?)
    end

    context 'when specifying the search options' do

      let(:given_search_options) { double(:given_search_options) }

      it 'sets the search options' do
        subject.search(given_query, given_search_options)
        expect(subject.send(:search_options)).to eq given_search_options
      end

    end

    context 'when not specifying any search options' do

      let(:default_search_options) { subject.class.default_search_options }

      it 'sets the search options to defaults' do
        subject.search(given_query)
        expect(subject.send(:search_options)).to eq default_search_options
      end

    end

    it 'searches for Github repositories the results' do
      subject.search(given_query)
      expect(subject).to have_received(:perform_search)
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

  describe :perform_search do

    let(:github_client) { subject.send(:github_client) }
    let(:search_options){ subject.send(:search_options) }

    it "searches for Github repositories using Github's API", :vcr do
      subject.query = given_query
      results = subject.send(:perform_search)
      results.items.should have(1).item
    end

    it "searches for Github repositories with the given query and the default search options" do
      allow(github_client).to receive(:new_search_repositories).with(search_query, search_options)
      subject.send(:perform_search)
      expect(github_client).to have_received(:new_search_repositories).with(search_query, search_options)
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
      subject.send(:perform_search)
    end

    it 'creates an array of respo search results for the search response items', :vcr do
      parsed_results.should have(1).item
      repo_result = parsed_results.first
      repo_result.should be_an_instance_of(Github::RepoSearchResult)
      repo_result.name.should eq repo_name
    end

  end

end
