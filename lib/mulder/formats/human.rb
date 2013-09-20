require 'awesome_print'

module Mulder
  module Formats
    class Human < Base

      def output
        ap instances.collect(&:as_hash), { index: false, sort: true }
      end

    end
  end
end