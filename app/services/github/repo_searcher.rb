require 'octokit'
require 'services/github/repo_search_result'

class Github::RepoSearcher

  GITHUB_ORGANIZATION_NAME = 'iic-ninjas'

  SEARCH_RESULTS_LIMIT = 4

  attr_accessor :client, :query, :search_results

  def initialize(query)
    @query = query
  end

  def self.search(query)
    self.new(query)
    if valid_results?
      parse_results
    else
      []
    end
  end

  private

  def search_results
    @search_results ||= client.search_repositories(query, search_options)
  end

  def valid_results?
    search_results.present? and search_results.total_count > 0
  end

  def parse_results
    search_results.items.first(SEARCH_RESULTS_LIMIT).map do |repo|
      RepoSearchResult.new(repo)
    end
  end

  # we create a client to handle Github's Rate Limiting
  # see: http://developer.github.com/v3/#rate-limiting
  def client
    @client ||= Octokit::Client.new
  end

  def self.search_options
    "#{organization_filter}"
  end

  def self.organization_filter
    "@#{GITHUB_ORGANIZATION_NAME}"
  end

  #def repository_info
  #  @repository_info ||= client.repository(@repository, :accept => RAW_ACCEPT)
  #end

end