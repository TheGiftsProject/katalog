require 'rouge/plugins/redcarpet'
module MarkdownSupport

  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  extend ControllerSupport::Base

  before_filter :setup_markdown
  helper_method :markdown

  def markdown
    @markdown
  end

  def setup_markdown
    @markdown = Redcarpet::Markdown.new(HTML,
                                        :autolink => true,
                                        :space_after_headers => true,
                                        :fenced_code_blocks => true,
                                        :disable_indented_code_blocks => true
    )
  end

end