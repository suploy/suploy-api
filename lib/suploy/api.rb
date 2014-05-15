require 'json'
require 'excon'

module Suploy
  module Api
    require 'suploy/api/version'
    require 'suploy/api/error'
    require 'suploy/api/base'
    require 'suploy/api/credentials'
    require 'suploy/api/connection'
    require 'suploy/api/sshkey'
    require 'suploy/api/util'

    def connection
      @connection ||= Connection.new(url, options)
    end

    def reset_connection!
      @connection = nil
    end

    def url
      @url
    end

    def url=(new_url)
      @url = new_url
      reset_connection!
    end

    def options
      @options ||= {}
    end

    def options=(new_options)
      @options = new_options
      reset_connection!
    end
  end
end
