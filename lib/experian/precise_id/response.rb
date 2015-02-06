module Experian
  module PreciseId
    class Response < Experian::Response

      def ssn
        @response['Products']['PreciseIDServer']['Checkpoint']['SSNFinderDetail']['SSNOnFile']
      end

    end
  end
end
