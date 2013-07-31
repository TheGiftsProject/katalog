module PostSupport

  extend ControllerSupport::Base
  include ProjectSupport

  def current_post
    @_current_post ||= load_post
  end

  def load_post
    post_id = params[:post_id] || params[:id]
    current_project.posts.find(post_id.to_i)
  end

end