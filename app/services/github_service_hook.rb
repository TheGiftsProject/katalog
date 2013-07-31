require 'github_grabber'

# see: https://help.github.com/articles/post-receive-hooks
class GithubServiceHook

  attr_accessor :payload

  MASTER_BRANCH_REF = "refs/heads/master"

  def initialize(project)
    @project = project
  end

  def process_payload(payload)
    @payload = payload
    if matching_project?
      sync_last_commit
      sync_contributors
    end
  end

  private

  def matching_project?
    @project.same_repo? @payload.repository_url
  end

  def sync_last_commit
    @project.last_commit_date = @payload.last_commit_date
    @project.save!
  end

  def sync_contributors
    @project.sync_contributors unless contributors_synced?
  end

  def contributors_synced?
    @project.includes_contributors?(@payload.contributors_emails)
  end

end