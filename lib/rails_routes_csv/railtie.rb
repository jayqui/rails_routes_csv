# frozen_string_literal: true

require 'rails_routes_csv'
require 'rails'

module RailsRoutesCsv
  class Railtie < Rails::Railtie
    railtie_name :rails_routes_csv

    rake_tasks do
      load File.expand_path('../tasks/routes.rake', __dir__)
    end
  end
end
