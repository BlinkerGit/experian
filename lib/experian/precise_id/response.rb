module Experian
  module PreciseId
    class Response < Experian::Response

      def error_code
        if @response.has_key?('Products') && @response['Products'].has_key?('PreciseIDServer') && @response['Products']['PreciseIDServer'].has_key?('Error') && @response['Products']['PreciseIDServer']['Error'].has_key?('ErrorCode')
          @response['Products']['PreciseIDServer']['Error']['ErrorCode']
        end
      end

      def error_message
        if @response.has_key?('Products') && @response['Products'].has_key?('PreciseIDServer') && @response['Products']['PreciseIDServer'].has_key?('Error') && @response['Products']['PreciseIDServer']['Error'].has_key?('ErrorDescription')
          @response['Products']['PreciseIDServer']['Error']['ErrorDescription']
        else
          'Unknown'
        end
      end

      def success?
        completion_code == "0000"
      end

      def error?
        completion_code != "0000" || (@response.has_key?('Products') && @response['Products'].has_key?('PreciseIDServer') && @response['Products']['PreciseIDServer'].has_key?('Error'))
      end

      def ssn
        return '' unless @response.has_key?('Products') && @response['Products'].has_key?('PreciseIDServer') && @response['Products']['PreciseIDServer'].has_key?('Checkpoint') && @response['Products']['PreciseIDServer']['Checkpoint'].has_key?('SSNFinderDetail') && @response['Products']['PreciseIDServer']['Checkpoint']['SSNFinderDetail'].has_key?('SSNOnFile')

        @response['Products']['PreciseIDServer']['Checkpoint']['SSNFinderDetail']['SSNOnFile']
      end

    end
  end
end
