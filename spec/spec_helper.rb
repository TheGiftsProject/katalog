
# Load pow environment variables into development and test environments
def load_powenv
  if FileTest.exist?(".powenv") and ENV["RAILS_ENV"] == 'test'
    begin
      # read contents of .powenv
      powenv = File.open(".powenv", "rb")
      contents = powenv.read
      # parse content and retrieve variables from file
      lines = contents.gsub("export ", "").split(/\n\r?/).reject{|line| line.blank?}
      lines.each do |line|
        keyValue = line.split("=", 2)
        next unless keyValue.count == 2
        # set environment variable set in .powenv
        ENV[keyValue.first] = keyValue.last.gsub("'",'').gsub('"','')
      end
      # close file pointer
      powenv.close
    rescue => e
    end
  end
end

def initialize_testing_environment
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  # hack to allow controller specs
  Katalog::Application.configure do
    config.secret_key_base = 'RAILS_SECRET_KEY_BASE'
  end

  load_powenv

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/spec_helpers/**/*.rb")].each {|f| require f}
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    config.treat_symbols_as_metadata_keys_with_true_values = true

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"

    config.include FactoryGirl::Syntax::Methods # Don't need to write FactoryGirl.create => create

    VCR.configure do |config|
      config.allow_http_connections_when_no_cassette = true
      config.default_cassette_options = { :record => :new_episodes}
      config.hook_into :webmock
      config.cassette_library_dir = 'spec/vcr'
      config.configure_rspec_metadata!
    end

    load "#{Rails.root}/db/seeds.rb"
  end
end

require 'spork'

# check if spork listener is active
if Spork.using_spork?

  require 'spork/ext/ruby-debug'

  Spork.prefork do
    initialize_testing_environment
    # Spork ActiveRecord Hacks
    ActiveSupport::Dependencies.clear
  end

  Spork.each_run do
    # When spork is run then the observers needs to be disabled on a test-by-test basis
    #ActiveRecord::Base.observers.disable :all

    FactoryGirl.reload

    #We want spork to refresh all the lib directory for each run so we won't have to reload guard
    Dir["#{Rails.root}/lib/**/*.rb"].each do |file|
      load file
    end

    #We need this for guard to refresh the spec_helpers for each run
    Dir["#{Rails.root}/spec/spec_helpers/**/*.rb"].each do |file|
      load file
    end

  end

else
  initialize_testing_environment
end