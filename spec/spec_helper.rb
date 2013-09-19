require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mulder'
require 'mocha/api'

RSpec.configure do |config|

  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.run_all_when_everything_filtered = true

  config.filter_run :focus

  config.mock_with :mocha

  config.order = 'random'

  config.before(:suite) do
    Fog.mock!
  end
end
