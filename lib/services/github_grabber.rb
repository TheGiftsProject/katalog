require 'octokit'

class GithubGrabber

  RAW_ACCEPT = 'application/vnd.github.raw'
  HTML_ACCEPT = 'application/vnd.github.html'

  attr_accessor :client

  # see: GithubSupport
  cattr_accessor :hook_callback_url

  # we create a client to handle Github's Rate Limiting
  # see: http://developer.github.com/v3/#rate-limiting
  def initialize(repo)
    @repository = Octokit::Repository.new repo
    @client = Octokit::Client.new
  end

  def self.from_project(project)
    self.from_url(project.repo_url)
  end

  def self.from_url(project_url)
    repository = Octokit::Repository.from_url(project_url)
    GithubGrabber.new repository
  end

  def readme
    @client.readme(@repository, :accept => HTML_ACCEPT)
  end

  def changelog
    @client.contents(@repository, :path => 'CHANGELOG.md', :accept => HTML_ACCEPT)
  end

  def todo
    @client.contents(@repository, :path => 'TODO.md', :accept => HTML_ACCEPT)
  end

  def last_commit
    last_commit = master_branch.commit
    Hashie::Mash.new(
        sha: last_commit.sha,
        message: last_commit.commit.message,
        date: last_commit.commit.committer.date
    )
  end

  def website
    repository_info.homepage
  end

  def contributors
    @client.contributors(@repository, false, :accept => RAW_ACCEPT)
  end

  def subscribe_to_service_hook
    @client.subscribe(subscribe_topic, GithubGrabber.hook_callback_url)
  end

  def unsubscribe_to_service_hook
    @client.unsubscribe(subscribe_topic, GithubGrabber.hook_callback_url)
  end

  private

  def repository_info
    @repository_info ||= @client.repository(@repository, :accept => RAW_ACCEPT)
  end

  def master_branch
    @master_branch ||= @client.branch(@repository, 'master', :accept => RAW_ACCEPT)
  end

  def subscribe_topic
    "#{Octokit.web_endpoint}#{@repository}/events/push"
  end

end