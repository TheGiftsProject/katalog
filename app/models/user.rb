class User < ActiveRecord::Base

  include User::GithubConcern
  include User::GravatarConcern

  has_and_belongs_to_many :projects
  has_many :posts, :dependent => :destroy

  def nickname
    self[:nickname] || self[:name]
  end

  def image
    if gravatar_id.present?
      gravatar
    else
      self[:image]
    end
  end

end