require "bundler/setup"
require "zip2tz"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.formatter = :progress

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  if ENV.key? 'CI'
    config.before(:example, :focus) { raise 'Should not commit focused specs' }
    config.fail_if_no_examples = true
  else
    config.filter_run_when_matching :focus
    config.fail_fast = ENV.key? 'RSPEC_FAIL_FAST'
  end

  config.order = :random
  Kernel.srand config.seed
end
