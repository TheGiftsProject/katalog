class GithubActivityUpdater

  TIME_THRESHOLD_FOR_PROJECT_ACTIVITY_UPDATE = 6.months
  TIME_SINCE_LAST_ACTIVITY_UPDATE = 1.day

  def initialize
    @api = github_api_client
  end

  def update_activity
    relevant_projects.each do |project|
      Rails.logger.info("Checking for Github activity for `#{project.title}`.")
      repo_name = project.github_repo_name
      branches = branches_of_project(repo_name)
      branches.each do |branch_name|
        Rails.logger.info("Checking for Github activity in branch `#{branch_name}`.")
        commits = commits_of_branch(branch_name)
        commits_by_user = map_commits(commits).group_by(&:committer)
        commits_by_user.each do |github_nickname, commits_dates|
          user = User.find_by(:nickname => github_nickname)
          if user.present?
            latest_commit_date = commits_dates.max
            update_user_activity(user, project, latest_commit_date)
          end
        end
      end
    end
  end

  private

  def github_api_client
    Octokit::Client.new(:access_token => ENV['GITHUB_SECRET'])
  end

  def relevant_projects
    Project.where('updated_at > ?', TIME_THRESHOLD_FOR_PROJECT_ACTIVITY_UPDATE.ago).have_github_repo
  end

  def branches_of_project(repo_name)
    @api.branches(repo_name).map(&:name)
  end

  def commits_of_branch(branch_name)
    @api.commits_since(repo_name, TIME_SINCE_LAST_ACTIVITY_UPDATE.ago, branch_name)
  end

  def map_commits(commits)
    commits.map do |commit|
      OpenStruct.new({
        :updated_at => commit[:commit][:author][:date],
        :committer => commit[:committer][:login]
      })
    end
  end

  def update_user_activity(user, project, latest_commit_date)
    Rails.logger.info("Updating activity for user `#{user.nickname}` in `#{project.title}`.")
    user.projects << project unless user.projects.include?(project)

    project.update(:updated_at => latest_commit_date) if project.updated_at < latest_commit_date

    project_update = user.project_updates.find_or_create_by(:project => project)
    project_update.update(:updated_at => latest_commit_date) if project_update.updated_at < latest_commit_date
  end

end