class Project < ActiveRecord::Base

  belongs_to :ideator, :class_name => 'User'
  belongs_to :organization
  has_and_belongs_to_many :users
  has_many :posts, :dependent => :destroy
  has_many :likes, :dependent => :destroy
  has_many :project_updates, :dependent => :destroy

  self.per_page = 8

  enum :status, [:idea, :lifted]

  scope :latest_first, -> { order('projects.updated_at DESC') }
  scope :up_to_time_ago, -> (time) { where(:updated_at => time.ago..DateTime.now) }
  scope :search, -> (query) { query.blank? ? none : where('lower(title) like ? or lower(title) like ?',
                                                              "#{query.downcase}%", "% #{query.downcase}%")}
  scope :of_user, -> (user) { includes(:users).where(:users => {:id => user.id}) }
  scope :latest_first_by_user_update, -> { joins(:project_updates).order('project_updates.updated_at DESC').where('project_updates.user_id = users.id') }

  validates_presence_of :subtitle, :title

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

  private

  def slug
    "#{id}-#{title.parameterize}"
  end

end