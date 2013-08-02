require 'spec_helper'

describe AutocompleteController do

  describe :repositories do

    let(:given_query) { 'backbone' }
    let(:search_results) { 'json_result' }

    it 'searches Github repository for the given query' do
      allow(controller.repo_search).to receive(:search).with(given_query).and_return(search_results)
      post :repositories, :q => given_query
      expect(controller.repo_search).to have_received(:search).with(given_query).and_return(search_results)
    end

    it 'renders the repository search results as json' do
      post :repositories, :q => given_query
      expect(response.body).to search_results.to_json
    end

  end

end