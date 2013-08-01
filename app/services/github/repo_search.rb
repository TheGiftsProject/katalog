require 'octokit'

class Github::RepoSeach

  GITHUB_ORGANIZATION_NAME = 'iic-ninjas'

  attr_accessor :client, :query

  def initialize
  end

  def search(query)
    client.search_repositories(query, search_options)
  end

  private

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