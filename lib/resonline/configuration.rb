module Resonline
  class Configuration
    attr_accessor :cm_username, :cm_password, :username, :password, :hotel_id
  end

  class << self
    attr_accessor :configuration
  end

  # Configure Resonline someplace sensible,
  # like config/initializers/resonline.rb
  #
  # @example
  #   Resonline.configure do |config|
  #     config.cm_username = 'your channel manager username'
  #     config.cm_password = 'your channel manager password'
  #     config.username = 'your username'
  #     config.password = 'your password'
  #   end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end