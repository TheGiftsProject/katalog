class Project < ActiveRecord::Base

  belongs_to :ideator, :class_name => 'User'
  belongs_to :organization
  has_and_belongs_to_many :users
  has_many :posts, :dependent => :destroy
  has_many :project_updates, :dependent => :destroy

  self.per_page = 8

  enum :status, [:idea, :lifted]

  GITHUB_REPO_HOST = 'https://github.com/'

  scope :have_github_repo, -> { where("repo_url LIKE '#{GITHUB_REPO_HOST}%'") }
  scope :latest_first, -> { order('projects.updated_at DESC') }
  scope :search, -> (query) { query.blank? ? none : where('lower(title) like ? or lower(title) like ?',
                                                              "#{query.downcase}%", "% #{query.downcase}%")}
  scope :of_user, -> (user) { includes(:users).where(:users => {:id => user.id}) }
  scope :order_by_user_update, -> (user, time) { includes(:project_updates).
                                                 where('project_updates.user_id = ?', user.id).
                                                 order("CASE WHEN (project_updates.updated_at >= '#{time.ago}') THEN (projects.updated_at) ELSE (project_updates.updated_at) END DESC")
                                               }

  validates_presence_of :title

  def to_param
    slug
  end

  def less_than_week_old?
    self.created_at > 1.week.ago
  end

  def ideator
    self[:ideator].presence || users.first
  end

  def lift!
    update(
      lifted_at: DateTime.now,
      status: :lifted
    )
  end

  def github_repo_name
    return nil if repo_url.blank?
    repo_url.sub(GITHUB_REPO_HOST, '')
  end

  private

  def slug
    "#{id}-#{title.parameterize}"
  end

end
