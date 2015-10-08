module Experian
  module PreciseId
    class Client < Experian::Client

      def verify_identity(options = {})
        assert_precise_id_options(options)
        @request = Request.new(options)
        @response = Response.new(submit_request)
      end

      def assert_precise_id_options(options)
        return if options[:first_name] && options[:last_name]  && options[:street] && options[:zip] && options[:dob] && options[:city] && options[:state] && options[:precise_id_type] && options[:reference_number]
        raise Experian::ArgumentError, "Required options missing: first_name, last_name, street, city, state, zip, dob, reference_number, precise_id_type"
      end

    end
  end
end
