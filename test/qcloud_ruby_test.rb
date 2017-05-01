require 'test_helper'
require 'json'

class QcloudRubyTest < Minitest::Test
  def setup
    ::QcloudRuby.configure do |config|
      config.secret_id = 'Secret id'
      config.secret_key = 'Secret key'
    end
  end

  def test_url
    client = ::QcloudRuby::Client.new do |c|
      c.service_type = ::QcloudRuby::ServiceType::CVM
    end

    assert_equal 'cvm.api.qcloud.com/v2/index.php', client.url
  end

  def test_post_should_be_work
    resp = ::QcloudRuby.post(
      service_type: ::QcloudRuby::ServiceType::ACCOUNT,
      region: 'gz',
      action: 'DescribeProject'
    )

    assert_equal 0, JSON.parse(resp.body).fetch('code')
  end

  def test_get_should_be_work
    resp = ::QcloudRuby.get(
      service_type: ::QcloudRuby::ServiceType::CVM,
      region: 'gz',
      action: 'DescribeInstances'
    )

    assert_equal 0, JSON.parse(resp.body).fetch('code')
  end

  def test_with_unknow_region
    resp = ::QcloudRuby.post(
      service_type: ::QcloudRuby::ServiceType::CVM,
      region: 'unknow',
      action: 'DescribeInstances'
    )

    refute_equal 0, JSON.parse(resp.body).fetch('code')
  end

  def test_with_unknow_service_type
    resp = ::QcloudRuby.post(
      service_type: ::QcloudRuby::ServiceType::LB,
      region: 'gz',
      action: 'DescribeInstances'
    )

    refute_equal 0, JSON.parse(resp.body).fetch('code')
  end
end
