module S3FormHelper

  def s3_form_data_fields
    fields = {
        :key => key,
        :acl => acl,
        :AWSAccessKeyId => S3DirectUpload.config.access_key_id,
        :policy => policy,
        :signature => signature,
        :success_action_status => success_action_status,
        'X-Requested-With' => 'xhr',
        'Content-Type' => '',
        'content-type' => 'image/jpeg'
    }

    javascript_tag <<-END
      PostView.formDataFields = #{fields.to_json}
    END
  end

  #def key
  #  "#{key_starts_with}{timestamp}-{unique_id}-#{SecureRandom.hex}/${filename}"
  #end

  def key
    "#{key_starts_with}#{SecureRandom.hex}/bozaglo.jpg"
  end

  def policy
    Base64.encode64(policy_data.to_json).gsub("\n", "")
  end

  def signature
    Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), S3DirectUpload.config.secret_access_key, policy)).gsub('\n', '')
  end

  def key_starts_with
    'uploads/'
  end

  def acl
    'public-read'
  end

  def success_action_status
    '201'
  end

  def policy_data
    {
        expiration: 10.hours.from_now.utc.iso8601,
        conditions: [
            ["starts-with", "$utf8", ""],
            ["starts-with", "$key", key_starts_with],
            ["starts-with", "$x-requested-with", ""],
            ["content-length-range", 0, 500.megabytes],
            ["starts-with","$content-type",""],
            {bucket: S3DirectUpload.config.bucket},
            {acl: acl},
            {success_action_status: success_action_status}
        ]
    }
  end

end