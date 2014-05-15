module Suploy::Api::Base
  include Suploy::Api::Error

  attr_accessor :connection
  attr_reader :id

  def initialize(connection, hash={})
    unless connection.is_a?(Suploy::Api::Connection)
      raise ArgumentError, "Expected a Suploy::Api::Connection, got: #{connection}."
    end
    @connection, @info, @id = connection, hash, hash['id']
  end
end
