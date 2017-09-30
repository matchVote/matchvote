CarrierWave.configure do |config|
  config.storage = :aws
  config.aws_credentials = { region: ENV.fetch('AWS_REGION') }
  config.aws_bucket = ENV.fetch('MV_PROFILE_PIC_BUCKET')
  config.aws_acl = 'public-read'
  config.enable_processing = false if Rails.env.test?
end
