class Post < ActiveRecord::Base

  belongs_to :project
  belongs_to :user

  enum :story, [:none, :to_wip, :to_done, :to_dead]

end