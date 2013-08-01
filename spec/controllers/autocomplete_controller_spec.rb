require 'spec_helper'


describe AutocompleteController do

  describe :repositories do

    let(:given_query) { 'backbone' }
    let(:json_result) { 'json_result' }

    before do
      allow(controller.repo_search).to receive(:search).with(given_query).and_return(json_result)
    end

    it 'searches Github repository for the given query' do
      post :repositories, :q => given_query
      expect(controller.repo_search).to have_received(:search).with(given_query)
    end

    it 'renders the repository search results as json' do
      post :repositories, :q => given_query
      expect(response.body).to json_result
    end

  end

end