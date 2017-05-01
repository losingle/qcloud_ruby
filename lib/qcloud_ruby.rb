module QcloudRuby
  class << self
    attr_accessor :configuration
  end

  def self.configure
    @configuration ||= ::QcloudRuby::Configuration.new
    yield @configuration
  end

  def self.get(service_type: nil, **params)
    client = ::QcloudRuby::Client.new do |c|
      c.service_type = service_type
    end

    client.request(method: 'GET', **params)
  end

  def self.post(service_type: nil, **params)
    client = ::QcloudRuby::Client.new do |c|
      c.service_type = service_type
    end
    
    client.request(method: 'POST', **params)
  end
end

require "qcloud_ruby/service_type"
require "qcloud_ruby/configuration"
require "qcloud_ruby/client"
require "qcloud_ruby/version"
