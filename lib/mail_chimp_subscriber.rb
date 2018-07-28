require 'net/http'
require 'uri'

class MailChimpSubscriber
  API_VERSION = '3.0'

  def domain
    @domain ||= URI.parse("https://#{data_center}.api.mailchimp.com")
  end

  def batch(users)
    post(operations: users.map(&method(:user_data)).map(&method(:operation)))
  end

  private

  def user_data(user)
    # merge_fields are arbitrary but must be set up in the MailChimp list before hand.
    {
      email_address: user.email,
      status: "subscribed",
      merge_fields: {
        USERNAME: user.username,
      }
    }
  end

  def operation(data)
    {
      operation_id: "batch subscribe users",
      method: "POST",
      path: "lists/#{ENV['MAILCHIMP_LIST_ID']}/members",
      body: data.to_json
    }
  end

  def post(data)
    batch_uri = URI.join(domain, "/#{API_VERSION}/", "batches")
    request = Net::HTTP::Post.new(batch_uri, 'Content-Type' => 'application/json')
    request.basic_auth(ENV['MAILCHIMP_USERNAME'], ENV['MAILCHIMP_API_KEY'])
    request.body = data.to_json
    https.request(request)
  end

  def https
    Net::HTTP.new(domain.host, domain.port).tap do |https|
      https.use_ssl = true
    end
  end

  def data_center
    ENV['MAILCHIMP_API_KEY'].match(/-(us\d+)/)[1]
  rescue NoMethodError
    msg = 'Data center not parseable from MAILCHIMP_API_KEY'
    raise MailChimpException.new(msg)
  end
end

class MailChimpException < Exception
end
