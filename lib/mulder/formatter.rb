require_relative 'formats/base'
require_relative 'formats/human'
require_relative 'formats/json'

module Mulder
  class Formatter

    VALID_FORMATS = {
      'human' => Formats::Human,
      'json'  => Formats::JSON
    }

    def initialize(instances, format)
      unless VALID_FORMATS.keys.include?(format)
        raise NotImplementedError.new("Formatting as #{format} has not been implemented!")
      end

      @instances = instances
      @format    = VALID_FORMATS[format]
    end

    def output
      @format.new(@instances).output
    end
  end

end
