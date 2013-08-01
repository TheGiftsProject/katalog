S3Storage = OpenStruct.new(
    :access_key_id => ENV['KATALOG_AWS_ID'],
    :secret_access_key => ENV['KATALOG_AWS_ACCESS_KEY'],
    :bucket => ENV['KATALOG_AWS_BUCKET_NAME']
)