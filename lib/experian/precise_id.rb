require 'experian/precise_id/client'
require 'experian/precise_id/request'
require 'experian/precise_id/response'

module Experian
  module PreciseId

    MATCH_CODES = {
        "A" => "Deceased/Non-Issued Social Security Number",
        "B" => "No Record Found",
        "C" => "ID Match",
        "D" => "ID Match to Other Name",
        "E" => "ID No Match"
    }

    DB_HOST = "PRECISE_ID"
    DB_HOST_TEST = "PRECISE_ID_TEST"

    def self.db_host
      Experian.test_mode? ? DB_HOST_TEST : DB_HOST
    end

    # convenience method
    def self.verify_identity(options = {})
      Client.new.verify_identity(options)
    end
  end
end
