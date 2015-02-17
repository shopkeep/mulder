require 'json'

module Mulder
  module Formats
    class JSON < Base
      attr_writer :stream

      def stream
        @stream || STDOUT
      end

      def output
        stream.write(instances.collect(&:as_hash).to_json)
      end

    end
  end
end
