require 'services/github_grabber'

class GithubServiceHook

  MASTER_BRANCH_REF = "refs/heads/master"

  def initialize(project, payload = nil)
    @project = project
    with_payload(payload) if payload.present?
  end

  # see: https://help.github.com/articles/post-receive-hooks
  def with_payload(payload)
    @payload = payload
  end

  def process_payload
    if has_matching_project?
      sync_last_commit
      sync_contributors
    end
  end

  private

  def has_matching_project?
    @project.is_same_repo? @payload.repository_url
  end

  def sync_last_commit
    @project.last_commit_date = @payload.last_commit_date
    @project.save!
  end

  def sync_contributors
    if should_sync_contributors
      puts 'should_sync_contributors'
      @project.sync_contributors
    else
      puts 'dont sync shit'
    end
  end

  def should_sync_contributors
    contributors_emails = Set.new(@project.users.map(&:email))
    new_contributors_emails = Set.new(@payload.contributors_emails)
    not contributors_emails.subset?(new_contributors_emails)
  end

end