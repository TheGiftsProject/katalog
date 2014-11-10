class ProjectUpdate < ActiveRecord::Base

  belongs_to :project
  belongs_to :user

  scope :updated_in, -> (time_threshold) { where('updated_at > ?', time_threshold.ago) }
  scope :latest_first, -> { order('updated_at DESC') }

end