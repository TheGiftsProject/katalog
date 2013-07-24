S3DirectUpload.config do |c|
  c.access_key_id = ENV['KATALOG_AWS_ID']
  c.secret_access_key = ENV['KATALOG_ACCESS_KEY']
  c.bucket = 'katalog-images'
end