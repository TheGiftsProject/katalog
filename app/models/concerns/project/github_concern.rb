
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

  #TODO: covert date format???
  def sync_last_commit_date
    self.last_commit_date = Date.now #github_grabber.last_commit.date
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

  # see: http://developer.github.com/v3/repos/collaborators/
  def assign_contributor(contributor)

    new_contributor = User.find_or_initialize_by(uid: contributor.id) do |u|
      u.name = contributor.login
      u.nickname = contributor.login
      u.image = contributor.avatar_url
      u.projects << self

      # where is the email?! see: http://developer.github.com/v3/users/emails/
      #u.email = contributor.login
    end

    # if the user already exists then just add it to his projects
    new_contributor.projects << self
    new_contributor.save!
  end

end