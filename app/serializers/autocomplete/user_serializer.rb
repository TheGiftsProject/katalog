class Autocomplete::UserSerializer < ActiveModel::Serializer
  attributes :name, :nickname, :url, :image

  def url
    user_projects_url(:username => object.nickname)
  end
end