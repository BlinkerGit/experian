module Experian
  module PreciseId
    class Client < Experian::Client

      def submit_request
        connection = Excon.new(precise_uri, idempotent: true)
        @raw_response = connection.post(body: request_body, headers: request_headers)
        raise Experian::Forbidden, "Invalid Experian login credentials" if invalid_login?
        @raw_response.body

      rescue Excon::Errors::SocketError => e
        raise Experian::ClientError, "Could not connect to Experian: #{e.message}"
      end

      def precise_uri
        "https://#{Experian.test_mode ? 'dm-sgw1' : 'pid-sgw.secure'}.experian.com/fraudsolutions/xmlgateway/preciseid"
      end

      def verify_identity(options = {})
        assert_precise_id_options(options)
        @request = Request.new(options)
        @response = Response.new(submit_request)
      end

      def assert_precise_id_options(options)
        return if options[:first_name] && options[:last_name]  && options[:street] && options[:zip] && options[:dob] && options[:city] && options[:state] && options[:precise_id_type] && options[:reference_number]
        raise Experian::ArgumentError, "Required options missing: first_name, last_name, street, city, state, zip, dob, reference_number, precise_id_type"
      end

      def invalid_login?
        @raw_response.body =~ /<ns1:faultstring>/ || super
      end

    end
  end
end
