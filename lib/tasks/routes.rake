require 'csv'

namespace :routes do
  desc 'Exports all application routes to a CSV file.'
  task csv: :environment do
    csv_file = Rails.root.join('routes.csv')
    routes = Rails.application.routes.routes

    CSV.open(csv_file, 'w') do |csv|
      csv << ['Prefix', 'Verb', 'URI Pattern', 'Controller#Action'] # Header

      routes.each do |route|
        # From `rake routes` source, to skip internal info routes
        next if route.path.spec.to_s.start_with?('/rails/info')

        controller = route.defaults[:controller]
        action = route.defaults[:action]

        # Skip routes that are redirects or don't have a controller
        next unless controller

        csv << [
          route.name,
          route.verb,
          route.path.spec.to_s.sub('(.:format)', ''),
          "#{controller}##{action}"
        ]
      end
    end

    puts "Routes have been exported to #{csv_file}"
  end
end
