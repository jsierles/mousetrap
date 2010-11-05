$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'mousetrap'

require "bundler"
Bundler.setup

require 'rspec'
require 'factories'

require 'active_support/core_ext/hash'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

module Mousetrap
  class Resource
    def self.get(*args)
      raise 'You must stub this, or should_receive at a higher level.'
    end

    def self.post(*args)
      raise 'You must stub this, or should_receive at a higher level.'
    end
  end
end
