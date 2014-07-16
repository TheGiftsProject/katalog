class User < ActiveRecord::Base

  has_and_belongs_to_many :projects
  has_many :posts, :dependent => :destroy
  has_many :likes, :dependent => :destroy

  def nickname
    self[:nickname] || self[:name]
  end

  def shortname
    (self.name.presence || self.nickname).split(' ').first
  end

end