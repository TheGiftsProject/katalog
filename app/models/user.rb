class User < ActiveRecord::Base

  has_and_belongs_to_many :projects
  has_and_belongs_to_many :organizations
  belongs_to :default_organization, :class_name => 'Organization'
  has_many :posts, :dependent => :destroy
  has_many :project_updates, :dependent => :destroy

  scope :no_hidden, -> { where(:hidden => false) }

  def nickname
    self[:nickname] || self[:name]
  end

  def shortname
    (self.name.presence || self.nickname).split(' ').first
  end

end