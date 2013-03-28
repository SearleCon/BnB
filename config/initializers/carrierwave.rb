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
    URI.parse(uri)
  rescue URI::InvalidURIError
      uri_parts = uri.split('?')
      # regexp from Ruby's URI::Parser#regexp[:UNSAFE], with [] specifically removed
      encoded_uri = URI.encode(uri_parts.shift, /[^\-_.!~*'()a-zA-Z\d;\/?:@&=+$,]/)
      encoded_uri << '?' << URI.encode(uri_parts.join('?')) if uri_parts.any?
      URI.parse(encoded_uri) rescue raise CarrierWave::DownloadError, "couldn't parse URL"
  end
end