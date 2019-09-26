require 'forwardable'
require 'uri'
require 'openssl'
require 'base64'
require 'net/http'

module QcloudRuby
  class Client
    extend Forwardable

    attr_accessor :service_type

    def initialize(&block)
      self.instance_eval(&block)
    end

    def default_params(region, action)
      {
        Region: region,
        Action: action,
        SecretId: secret_id,
        Timestamp: timestamp,
        Nonce: nonce,
        Version: version,
        RequestClient: identity
      }
    end

    def gen_data(method, region, action, other_params)
      params = default_params(region, action)
                .merge!(other_params)
                .sort
                .to_h

      query_str = URI.encode_www_form(params)

      params.merge!(Signature: sign(method, query_str))
    end

    def request(method: 'POST', region: nil, action: nil, **other_params)
      data = gen_data(method, region, action, other_params)
      uri = URI(url_with_protocol)

      resp = if method == 'GET'
              uri.query = URI.encode_www_form(data)
              Net::HTTP.get_response(uri)
            else
              Net::HTTP.post_form(uri, data)
            end

      resp
    end

    def timestamp
      Time.now.to_i
    end

    def nonce
      (rand() * 65535).round
    end

    def identity
      "SDK_RUBY_#{::QcloudRuby::VERSION}"
    end

    def version
      '2017-03-12'
    end

    def host
      "#{service_type}.#{base_host}"
    end

    def url
      "#{host}#{path}"
    end

    def url_with_protocol
      "#{protocol}://#{url}"
    end

    def sign(method, query)
      source = method + url + '?' + query

      Base64.encode64(OpenSSL::HMAC.digest(
        OpenSSL::Digest.new('sha1'),
        secret_key, source))
      .strip
    end

    def_delegators :'QcloudRuby.configuration',
      :protocol, :secret_id, :secret_key, :base_host, :path
  end
end
