module Mulder
  module Formats
    class Base

      attr_reader :instances

      def initialize(instances)
        @instances = instances
      end

      def output
        raise NotImplementedError
      end

    end
  end
end