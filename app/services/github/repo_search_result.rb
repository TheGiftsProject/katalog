require 'hashie/trash'

class RepoSearchResult < Hashie::Trash

  property :repo_url, :from => :url
  property :name
  property :owner
  property :description
  property :language

end