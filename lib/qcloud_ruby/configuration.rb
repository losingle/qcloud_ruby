require 'digest/sha1'
require 'base64'

module QcloudRuby
  class Configuration
    attr_accessor :base_host, :ssl, :path, :secret_id, :secret_key, :base_host_v2, :path_v2

    def initialize
      @base_host = 'tencentcloudapi.com'
      @base_host_v2 = 'api.qcloud.com'
      @path_v2 = '/v2/index.php'
      @path      = '/'
      @ssl       = true
    end

    def protocol
      ssl? ? 'https' : 'http'
    end

    alias_method :ssl?, :ssl
  end
end
