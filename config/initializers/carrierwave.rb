CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => 'AKIAJPJJ2WP2VMHCMOIA',                        # required
      :aws_secret_access_key  => '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',
      :region => 'eu-west-1'
  }
  config.fog_directory  = 'bnbeezy'
end