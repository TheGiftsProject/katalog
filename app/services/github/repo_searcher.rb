require 'octokit'
require 'github/repo_search_result'

class Github::RepoSearcher

  GITHUB_ORGANIZATION_NAME = 'iic-ninjas'

  SEARCH_RESULTS_LIMIT = 4

  attr_accessor :client, :query

  def initialize(query)
    @query = query
  end

  def search
    if valid_results?
      parse_results
    else
      []
    end
  end

  private

  def search_results
    @search_results ||= github_client.search_repositories(search_query, self.class.search_options)
  end

  def valid_results?
    search_results.present? and search_results.count > 0
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

  def self.search_options
    {:per_page => SEARCH_RESULTS_LIMIT}
  end

  def self.organization_filter
    "@#{GITHUB_ORGANIZATION_NAME}"
  end

end