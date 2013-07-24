class Project < ActiveRecord::Base

  has_and_belongs_to_many :tags
  has_and_belongs_to_many :users
  has_many :posts

  enum :status, [:idea, :wip, :done, :dead]

  scope :latest_first, -> { order(:updated_at => :desc) }

  def to_param
    slug
  end

  private

  def slug
    "#{id}-#{title.parameterize}"
  end


end