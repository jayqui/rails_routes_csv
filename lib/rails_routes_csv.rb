# frozen_string_literal: true

require_relative 'rails_routes_csv/version'

module RailsRoutesCsv
  class Error < StandardError; end
  # Your code goes here...
end

require_relative 'rails_routes_csv/railtie' if defined?(Rails)
