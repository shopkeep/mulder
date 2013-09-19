require 'isomer'

module Mulder
  class Config < Isomer::Base
    parameter :aws_access_key_id
    parameter :aws_secret_access_key
  end
end