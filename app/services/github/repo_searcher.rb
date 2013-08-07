require 'octokit'
require 'github/repo_search_result'

module Github
  class RepoSearcher

    GITHUB_ORGANIZATION_NAME = 'iic-ninjas'

    LATEST_RESULTS_SORT_BY = :updated
    LATEST_RESULTS_LIMIT = 20

    SEARCH_RESULTS_LIMIT = 4

    attr_accessor :client, :query, :search_options

    def latest
      @search_options = self.class.latest_search_options
      search
    end

    def search(query = '')
      @query = query
      search_results
      if valid_results?
        parse_results
      else
        []
      end
    end

    private

    def search_results
      @search_results ||= github_client.search_repositories(search_query, search_options)
    end

    def valid_results?
      search_results.present? and search_results.total_count > 0
    end

    def parse_results
      search_results.items.map{ |repo| RepoSearchResult.new(repo) }
    end

    # we create a client to handle Github's Rate Limiting
    # see: http://developer.github.com/v3/#rate-limiting
    def github_client
      @client ||= Octokit::Client.new
    end

    def search_query
      "#{self.class.organization_filter} #{query}"
    end

    def search_options
      @search_options ||= self.class.default_search_options
    end

    def self.latest_search_options
      {:per_page => SEARCH_RESULTS_LIMIT, :sort => LATEST_RESULTS_SORT_BY}
    end

    def self.default_search_options
      {:per_page => SEARCH_RESULTS_LIMIT}
    end

    def self.organization_filter
      "@#{GITHUB_ORGANIZATION_NAME}"
    end

  end
end