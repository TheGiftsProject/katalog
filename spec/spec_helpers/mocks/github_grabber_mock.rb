require 'github_grabber'
require 'rspec/mocks'

class GithubGrabberMock < GithubGrabber

  private

  def client
    RSpec::Mocks::Mock.new('github-grabber-client').as_null_object
  end

end