CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => 'AKIAJPJJ2WP2VMHCMOIA',                        # required
      :aws_secret_access_key  => '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',
      :region => 'eu-west-1'
  }
  config.fog_directory  = 'bnbeezy'
  config.max_file_size  = 1.megabyte
end

CarrierWave::Uploader::Download.module_eval do
  def process_uri(uri)
    begin
      URI.parse(uri)
    rescue
      URI.parse(URI.escape(URI.unescape(uri)))
    end
  end
end