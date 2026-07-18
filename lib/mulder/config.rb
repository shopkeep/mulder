require 'isomer'

module Mulder
  CONFIG = Isomer::Nucleus.new do |n|
    n.parameter :aws_access_key_id
    n.parameter :aws_secret_access_key
  end
end
