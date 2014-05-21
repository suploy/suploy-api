#
# This comes directly from Docker-Api https://github.com/swipely/docker-api/blob/master/lib/docker/connection.rb
#
# This class represents a Connection to a Docker server. The Connection is
# immutable in that once the url and options is set they cannot be changed.
class Suploy::Api::Connection
  include Suploy::Api::Error

  attr_reader :url, :options

  # Create a new Connection. This method takes a url (String) and options
  # (Hash). These are passed to Excon, so any options valid for `Excon.new`
  # can be passed here.
  def initialize(url, opts = {})
    case
    when !url.is_a?(String)
      raise ArgumentError, "Expected a String, got: '#{url}'"
    when !opts.is_a?(Hash)
      raise ArgumentError, "Expected a Hash, got: '#{opts}'"
    else
      @url, @options = url, opts
    end
  end

  # The actual client that sends HTTP methods to the Docker server. This value
  # is not cached, since doing so may cause socket errors after bad requests.
  def resource
    Excon.new(url, options)
  end
  private :resource

  # Send a request to the server with the `
  def request(*args, &block)
    request = compile_request_params(*args, &block)
    #if Suploy::Api.logger
      #Suploy::Api.logger.debug(
        #[request[:method], request[:path], request[:query], request[:body]]
      #)
    #end
    resource.request(request).body
  rescue Excon::Errors::BadRequest => ex
    raise ClientError, ex.message
  rescue Excon::Errors::Unauthorized => ex
    raise UnauthorizedError, ex.message
  rescue Excon::Errors::NotFound => ex
    raise NotFoundError, ex.message
  rescue Excon::Errors::InternalServerError => ex
    raise ServerError, ex.message
  rescue Excon::Errors::Timeout => ex
    raise TimeoutError, ex.message
  end

  # Delegate all HTTP methods to the #request.
  [:get, :put, :post, :delete].each do |method|
    define_method(method) do |*args, &block| 
      request(method, *args, &block)
    end
  end

  def to_s
    "Suploy::Api::Connection { :url => #{url}, :options => #{options} }"
  end

private
  # Given an HTTP method, path, optional query, extra options, and block,
  # compiles a request.
  def compile_request_params(http_method, path, query = nil, opts = nil, &block)
    query ||= {}
    opts ||= {}
    headers = opts.delete(:headers) || {}
    headers.merge! Suploy::Api.headers
    content_type = 'application/json'
    user_agent = "Suploy/Suploy-API"
    {
      :method        => http_method,
      :path          => "/#{path}",
      :query         => query,
      :headers       => { 'Content-Type' => content_type,
                          'User-Agent'   => user_agent,
                        }.merge(headers),
      :expects       => (200..204),
      :idempotent    => http_method == :get,
      :request_block => block
    }.merge(opts).reject { |_, v| v.nil? }
  end
end
