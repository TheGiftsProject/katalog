require 'octokit'

class GithubGrabber

  DEFAULT_ACCEPT = 'application/vnd.github.raw'

  # we create a client to handle Github's Rate Limiting
  # see: http://developer.github.com/v3/#rate-limiting
  def initialize(project_name)
    @project_name = project_name
    @client = Octokit::Client.new
  end

  def readme
    @client.readme(@project_name, :accept => DEFAULT_ACCEPT)
  end

  def changelog
    @client.contents(@project_name, :path => 'CHANGELOG.md', :accept => DEFAULT_ACCEPT)
  end

  def todo
    @client.contents(@project_name, :path => 'TODO.md', :accept => DEFAULT_ACCEPT)
  end

  def last_commit
    #@client.list_commits(@project_name, 'master', :per_page => 1, :accept => DEFAULT_ACCEPT)
    master_branch['commit']
  end

  def website
    repository['homepage']
  end

  def contributors
    @client.list_commits(@project_name, :accept => DEFAULT_ACCEPT)
  end

  #private


  def repository
    @repository ||= @client.repository(@project_name, :accept => DEFAULT_ACCEPT)
  end

  def master_branch
    @master_branch ||= @client.branch(@project_name, 'master', :accept => DEFAULT_ACCEPT)
  end

  #def is_on_current_project?
  #  return if @repository.blank?
  #  @repository['name'] != @project_name
  #end
end