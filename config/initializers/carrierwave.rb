CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: ENV["MV_AWS_ACCESS_KEY_ID"],
    aws_secret_access_key: ENV["MV_AWS_SECRET_ACCESS_KEY"]
  }
  config.fog_directory = ENV["MV_PROFILE_PIC_BUCKET"]
  config.fog_public = false

  config.enable_processing = false if Rails.env.test?
end
