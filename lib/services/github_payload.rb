class GithubPayload

  class InvalidPayloadExcpetion < StandardError; end

  def initialize(payload)
    return raise InvalidPayloadExcpetion.new('Github Post-Receive Hook received empty payload') if @payload.blank?
    @payload = Hashie::Mash.new(JSON.parse(payload))
  rescue JSON::ParserError => e
    raise InvalidPayloadExcpetion.new("Github Post-Receive Hook received invalid payload: #{e.message}")
  end

  def repository_url
    @payload.repository.url
  end

  def contributors_usernames
    @payload.commits.map(&:committer).map(&:username)
  end

end