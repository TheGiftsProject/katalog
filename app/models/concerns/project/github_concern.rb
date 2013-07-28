
module Project::GithubConcern
  extend ActiveSupport::Concern

  # Goes into Project

  delegate :readme, :todo, :changelog,
           :website, :last_commit, :contributors,
           :subscribe_to_service_hook,
           :unsubscribe_to_service_hook, :to => :github_grabber


  def sync_with_github
    sync_website_url
    sync_last_commit_date
    sync_contributors
    save!
  end

  def sync_website_url
    self.website_url = 'github_grabber.website'
  end

  def sync_last_commit_date
    self.last_commit_date = github_grabber.last_commit.date
  end

  def sync_contributors
    existing_users_uids = self.users.map(&:uid)
    self.contributors.each do |contributor|
      assign_contributor(contributor) unless existing_users_uids.include?(contributor.id)
    end
  end

  private

  def github_grabber
    @github_grabber ||= GithubGrabber.from_project(self)
  end

  def assign_contributor(contributor)
    new_contributor = User.find_or_init_by_contributor(contributor)

    # if the user already exists then just add it to his projects
    new_contributor.projects << self
    new_contributor.save!
  end

end