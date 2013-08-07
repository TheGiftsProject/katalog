class User < ActiveRecord::Base

  include User::GithubConcern

  has_and_belongs_to_many :projects
  has_many :posts, :dependent => :destroy

  def nickname
    self[:nickname] || self[:name]
  end

end