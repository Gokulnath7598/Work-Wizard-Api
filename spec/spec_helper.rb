require 'rspec_api_documentation'
require 'simplecov'

SimpleCov.start

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  RspecApiDocumentation.configure do |config|
    config.format = :api_blueprint
    config.api_name = "Pharmaepass API"
    config.api_explanation = "Document"
    config.request_body_formatter = Proc.new { |params| params }
    config.response_body_formatter = Proc.new { |response_content_type, response_body| response_body }
  end

  config.after(:each) do
    if Rails.env.test?
      FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads/test"])
      FileUtils.rm_rf(Dir["#{Rails.root}/tmp/uploads/test"])
    end 
  end
end
