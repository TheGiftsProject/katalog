require 'octokit'

class Github::Grabber

  RAW_ACCEPT = 'application/vnd.github.raw'
  HTML_ACCEPT = 'application/vnd.github.html'

  attr_accessor :client

  # see: GithubSupport
  cattr_accessor :hook_callback_url

  # @param repo [Project] Either a Project model or anything supported by Octokit::Repository
  def initialize(repo)
    if repo.is_a? Project
      @repository = Octokit::Repository.from_url(repo.repo_url)
    else
      @repository = Octokit::Repository.new repo
    end
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
    client.contributors(@repository, false, :accept => RAW_ACCEPT)
  end

  # Subscribe to push events to the project's repository
  def subscribe_to_service_hook
    client.subscribe(subscribe_topic, Github::Grabber.hook_callback_url)
  end

  # Unsubscribe to push events to the project's repository
  def unsubscribe_to_service_hook
    client.unsubscribe(subscribe_topic, Github::Grabber.hook_callback_url)
  end

  private

  # we create a client to handle Github's Rate Limiting
  # see: http://developer.github.com/v3/#rate-limiting
  def client
    @client ||= Octokit::Client.new
  end

  def repository_info
    @repository_info ||= client.repository(@repository, :accept => RAW_ACCEPT)
  end

  def master_branch
    @master_branch ||= client.branch(@repository, 'master', :accept => RAW_ACCEPT)
  end

  def subscribe_topic
    "#{Octokit.web_endpoint}#{@repository}/events/push"
  end

end