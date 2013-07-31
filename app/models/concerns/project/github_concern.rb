
module Project::GithubConcern
  extend ActiveSupport::Concern

  # Goes into Project

  delegate :readme, :todo, :changelog,
           :website, :last_commit, :fetch_contributors,
           :subscribe_to_service_hook,
           :unsubscribe_to_service_hook, :to => :github_grabber


  def sync_with_github
    return unless should_sync_with_github?
    subscribe_to_service_hook
    sync_website_url
    sync_last_commit_date
    sync_contributors
    save!
  end

  def sync_website_url
    self.website_url = github_grabber.website
  end

  def sync_last_commit_date
    self.last_commit_date = github_grabber.last_commit.date
  end

  def last_commit_date=(date_string)
    self[:last_commit_date] = date_string.to_datetime
  end

  def sync_contributors
    existing_users_uids = self.users.map(&:uid)
    self.fetch_contributors.each do |contributor|
      assign_contributor(contributor) unless existing_users_uids.include?(contributor.id)
    end
  end

  def includes_contributors?(contributors_emails)
    current_contributors_emails = Set.new(self.users.map(&:email))
    new_contributors_emails = Set.new(contributors_emails)
    new_contributors_emails.subset?(current_contributors_emails)
  end

  # Compares the current Project's repo to a given repo url or Project's repo url
  #
  # @param repo [String, Project] Either a A GitHub repository url or a Project model
  def same_repo?(repo)
    repo = repo.repo_url if repo.is_a? Project
    current_repo = Octokit::Repository.from_url(self.repo_url)
    other_repo = Octokit::Repository.from_url(repo)
    current_repo.slug == other_repo.slug
  end

  def should_sync_with_github?
    self.repo_url.present?
  end

  private

  def github_grabber
    @github_grabber ||= GithubGrabber.new(self)
  end

  def assign_contributor(contributor)
    new_contributor = User.find_or_init_by_contributor(contributor)

    # if the user already exists then just add it to his projects
    new_contributor.projects << self
    new_contributor.save!
  end

end