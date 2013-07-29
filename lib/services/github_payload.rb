class GithubPayload

  class InvalidPayloadExcpetion < StandardError; end

  def initialize(raw_payload)
    return raise InvalidPayloadExcpetion.new('Github Post-Receive Hook received empty payload') if raw_payload.blank?
    @payload = Hashie::Mash.new(JSON.parse(raw_payload))
  rescue JSON::ParserError => e
    raise InvalidPayloadExcpetion.new("Github Post-Receive Hook received invalid payload: #{e.message}")
  end

  def repository_url
    @payload.repository.url
  end

  def contributors_emails
    @payload.commits.map(&:committer).map(&:email)
  end

  def last_commit_date
    @payload.head_commit.timestamp
  end

end