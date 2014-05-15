module Suploy
  module Api
    class SshKey
      include Suploy::Api::Base

      def self.create(name, content, opts = {}, conn = Suploy::Api.connection)
        sshkey_json = conn.delete("/api/ssh_keys/#{id}")
        hash = Suploy::Api::Util.parse_json(sshkey_json) || {}
        new(conn, hash)
      end

      def self.get(id, opts = {}, conn = Suploy::Api.connection)
        sshkey_json = conn.get("/api/ssh_keys/#{id}")
        hash = Suploy::Api::Util.parse_json(sshkey_json) || {}
        new(conn, hash)
      end

      def remove(opts = {})
        conn.delete("/api/ssh_keys/#{id}", opts)
        nil
      end

      private
      private_class_method :new
    end
  end
end
