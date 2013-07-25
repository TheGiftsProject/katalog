class Post < ActiveRecord::Base

  belongs_to :project
  belongs_to :user

  enum :story, [:nothing, :to_wip, :to_done, :to_dead]

end