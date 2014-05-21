module Suploy::Api::Error::Helpers
  def handle_unprocessable(exception)
    errors = JSON.parse(exception.response.body)
    full_errors = []
    errors.each do |k, v|
      # each argument has an array of errors
      v.each do |e|
        full_errors << "#{k.capitalize} #{e}"
      end
    end
    raise Suploy::Api::Error::UnprocessableEntity.new full_errors.join "\n"
  end

  module_function :handle_unprocessable
end
