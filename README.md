An unofficial Tencent Qcloud API SDK for Ruby
==================================

安装
----

```bash
gem install qcloud_ruby
```

使用
----

1.	使用之前请在腾讯云的[云 API 控制台](https://console.qcloud.com/capi)中创建自己的安全凭证(SecretId 和 SecretKey). SecretKey 要严格保管, 避免泄露.
2.	安装并引入本 SDK.

示例
----

```ruby
::QcloudRuby.configure do |config|
  config.secret_id = 'Secret id'
  config.secret_key = 'Secret key'
end

resp = ::QcloudRuby.post(
  service_type: ::QcloudRuby::ServiceType::ACCOUNT,
  region: 'gz',
  action: 'DescribeProject'
)

resp = ::QcloudRuby.get(
  service_type: ::QcloudRuby::ServiceType::CVM,
  region: 'gz',
  action: 'DescribeInstances'
)
```

SDK API
-------

请访问 [api.md](./api.md)

资源
----

-	[API 列表](https://www.qcloud.com/doc/api)
