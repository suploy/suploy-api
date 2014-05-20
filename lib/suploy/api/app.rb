module Suploy
  module Api
    class App
      include Suploy::Api::Base

      def self.create(name, opts = {}, conn = Suploy::Api.connection)
        body = {app:{name: name}}.to_json
        app_json = conn.post("/api/apps", {}, body: body)
        hash = Suploy::Api::Util.parse_json(app_json) || {}
        new(conn, hash)
      end

      def self.index(opts = {}, conn = Suploy::Api.connection)
        apps_json = conn.get("/api/apps")
        apps = Suploy::Api::Util.parse_json(apps_json) || {}
        apps.map! do |k|
          new(conn, k)
        end
      end

      def self.get(name, opts = {}, conn = Suploy::Api.connection)
        app_json = conn.get("/api/apps/#{name}")
        hash = Suploy::Api::Util.parse_json(app_json) || {}
        new(conn, hash)
      end

      def remove(opts = {})
        conn.delete("/api/apps/#{info["title"]}", opts)
        nil
      end

      private
      private_class_method :new
    end
  end
end
