class GithubServiceHook

  MASTER_BRANCH_REF = "refs/heads/master"

  def initialize(payload)
    @payload = Hashie::Mash.new(JSON.parse(payload))
  end

  # see: https://help.github.com/articles/post-receive-hooks
  def process_payload
    return Log.error('Github Post-Receive Hook received empty payload') if @payload.blank?

    if is_master_branch? and has_matching_project?
      sync_last_commit
      sync_contributors
    end
  end

  private

  # todo: should thid be find by repo id?
  def current_project
    @project ||= Project.find_by(repo_url: @payload.repository.url)
  end

  def has_matching_project?
    current_project.present?
  end

  def is_master_branch?
    @payload.ref == MASTER_BRANCH_REF
  end

  #TODO: covert date format???
  def sync_last_commit
    current_project.update_attributes( last_commit_date: @payload.head_commit.timestamp)
  end

  def sync_contributors
    commiters = @payload.commits.map(&:committer).map(&:username)
    project_contributers = project.users.map(&:nickname)
    project.sync_contributors unless project_contributers.include?(commiters)
  end

end