module User::GravatarConcern
  extend ActiveSupport::Concern

  # see: http://en.gravatar.com/site/implement/images/
  def gravatar
    "http://www.gravatar.com/avatar/#{gravatar_id}"
  end

end