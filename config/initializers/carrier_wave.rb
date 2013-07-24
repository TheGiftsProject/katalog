CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider => 'AWS',
      :aws_secret_key_id => ENV['KATALOG_AWS_ID'],
      :aws_secret_access_key => ENV['KATALOG_ACCESS_KEY']
  }
  config.fog_directory = 'katalog-images'
end