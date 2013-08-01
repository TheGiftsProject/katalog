require 'github/grabber'
require 'github/syncer'

# see: https://help.github.com/articles/post-receive-hooks
class Github::ServiceHook

  attr_accessor :payload, :project

  def initialize(project)
    @project = project
  end

  def process_payload(new_payload)
    @payload = new_payload
    if matching_project?
      sync_last_commit
      sync_contributors
    end
  end

  private

  def matching_project?
    project.same_repo? payload.repository_url
  end

  def sync_last_commit
    project.last_commit_date = payload.last_commit_date
    project.save!
  end

  def sync_contributors
    github_syncer.sync_contributors unless contributors_synced?
  end

  def contributors_synced?
    project.includes_contributors?(payload.contributors_emails)
  end

  def github_syncer
    @github_syncer ||= Github::Syncer.new(project)
  end

end