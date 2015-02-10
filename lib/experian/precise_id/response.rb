module Experian
  module PreciseId
    class Response < Experian::Response

      def ssn
        return '' unless @response.has_key?('Products') && @response['Products'].has_key?('PreciseIDServer') && @response['Products']['PreciseIDServer'].has_key?('Checkpoint') && @response['Products']['PreciseIDServer']['Checkpoint'].has_key?('SSNFinderDetail') && @response['Products']['PreciseIDServer']['Checkpoint']['SSNFinderDetail'].has_key?('SSNOnFile')

        @response['Products']['PreciseIDServer']['Checkpoint']['SSNFinderDetail']['SSNOnFile']
      end

    end
  end
end
