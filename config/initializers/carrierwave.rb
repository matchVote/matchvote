CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: "***REMOVED***",
    aws_secret_access_key: "***REMOVED***"
  }
  config.fog_directory = "mv-profile-pics"
  config.fog_public = false

  config.enable_processing = false if Rails.env.test?
end
