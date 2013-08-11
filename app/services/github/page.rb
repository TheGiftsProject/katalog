require 'octokit'

class Github::Page

  class InvalidProjectError < ArgumentError; end
  class FileNotFoundError < Octokit::NotFound; end

  RAW_ACCEPT = 'application/vnd.github.raw'
  HTML_ACCEPT = 'application/vnd.github.html'

  attr_accessor :client
  attr_reader :repository

  def initialize(project)
    raise InvalidProjectError.new unless project.has_a_repo?
    @repository = Octokit::Repository.from_url(project.repo_url)
  end

  def fetch_page
    yield
  rescue Octokit::NotFound => e
    raise FileNotFoundError
  end

  def readme
    self.fetch_page { client.readme(repository, :accept => HTML_ACCEPT) }
  end

  def changelog
    self.fetch_page { client.contents(repository, :path => 'CHANGELOG.md', :accept => HTML_ACCEPT) }
  end

  def todo
    self.fetch_page { client.contents(repository, :path => 'TODO.md', :accept => HTML_ACCEPT) }
  end

  private

  # we create a client to handle Github's Rate Limiting
  # see: http://developer.github.com/v3/#rate-limiting
  def client
    @client ||= Octokit::Client.new
  end

end