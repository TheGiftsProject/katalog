require 'spec_helper'

describe AutocompleteController do

  describe :repositories do

    before do
      controller.stub(:sign_in_required)
    end

    let(:search_results) { [{:repo_info => 'repo1'},{:repo_info => 'repo2'}] }
    let(:repo_searcher) { controller.send(:repo_searcher) }

    context 'when asked for the latest repositories' do

      it 'searches Github repository for the given query' do
        allow(repo_searcher).to receive(:latest)
        post :repositories, :latest => true
        expect(repo_searcher).to have_received(:latest)
      end

      it 'renders the repository search results as json' do
        allow(repo_searcher).to receive(:latest).and_return(search_results)
        post :repositories, :latest => true
        expect(response.body).to eq search_results.to_json
      end

    end

    context 'by default' do

      let(:given_query) { 'myawesome' }

      it 'searches Github repository for the given query' do
        allow(repo_searcher).to receive(:search)
        post :repositories, :q => given_query
        expect(repo_searcher).to have_received(:search).with(given_query)
      end

      it 'renders the repository search results as json' do
        allow(repo_searcher).to receive(:search).with(given_query).and_return(search_results)
        post :repositories, :q => given_query
        expect(response.body).to eq search_results.to_json
      end

    end

  end

end