module Suploy
  module Api
    class SshKey
      include Suploy::Api::Base

      def self.create(name, content, opts = {}, conn = Suploy::Api.connection)
        body = {ssh_key:{title: name, content: content}}.to_json
        sshkey_json = conn.post("/api/profiles/ssh_keys", {}, body: body)
        hash = Suploy::Api::Util.parse_json(sshkey_json) || {}
        new(conn, hash)
      rescue Excon::Errors::UnprocessableEntity => e
        Suploy::Api::Error::Helpers.handle_unprocessable e
      end

      def self.index(opts = {}, conn = Suploy::Api.connection)
        sshkeys_json = conn.get("/api/profiles/ssh_keys")
        sshkeys = Suploy::Api::Util.parse_json(sshkeys_json) || {}
        sshkeys.map! do |k|
          new(conn, k)
        end
      end

      def self.get(name, opts = {}, conn = Suploy::Api.connection)
        sshkey_json = conn.get("/api/profiles/ssh_keys/#{name}")
        hash = Suploy::Api::Util.parse_json(sshkey_json) || {}
        new(conn, hash)
      rescue NotFoundError
        raise NotFoundError.new "The SSH Key '#{name}' does not exist."
      end

      def remove(opts = {})
        conn.delete("/api/profiles/ssh_keys/#{info["title"]}", opts)
        nil
      end

      private
      private_class_method :new
    end
  end
end
