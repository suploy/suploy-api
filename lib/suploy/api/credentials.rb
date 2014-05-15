module Suploy
  module Api
    class Credentials
      include Suploy::Api::Base

      def self.login(email, password, conn = Suploy::Api.connection)
        opts = {user_email: email, user_password: password}
        response = conn.post('/api/session', {}, body: opts.to_json)
        hash = Suploy::Api::Util.parse_json(response) || {}
        new(conn, hash)
      end
    end
  end
end
