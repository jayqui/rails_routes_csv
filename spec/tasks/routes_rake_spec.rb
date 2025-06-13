# frozen_string_literal: true

require 'spec_helper'
require 'rake'
require 'csv'
require 'fileutils'
require 'pathname'

RSpec.describe 'routes:csv' do
  let(:rake) { Rake::Application.new }
  let(:task_path) { 'lib/tasks/routes.rake' }
  let(:csv_file) { Rails.root.join('routes.csv') }
  let(:app_double) { double('Application') }
  let(:routes_double) { double('Routes') }

  before do
    # Stub the Rails constant and its methods
    stub_const('Rails', double('Rails'))
    allow(Rails).to receive(:root).and_return(Pathname.new(File.expand_path('../..', __dir__)))
    allow(Rails).to receive(:application).and_return(app_double)
    allow(app_double).to receive(:routes).and_return(routes_double)

    Rake.application = rake
    # Define a dummy environment task
    Rake::Task.define_task(:environment)
    load task_path

    # Mock the individual routes
    route1 = double('Route', name: 'users', verb: 'GET', path: double(spec: double(to_s: '/users(.:format)')),
                             defaults: { controller: 'users', action: 'index' })
    route2 = double('Route', name: 'new_user', verb: 'GET', path: double(spec: double(to_s: '/users/new(.:format)')),
                             defaults: { controller: 'users', action: 'new' })
    internal_route = double('Route', name: nil, verb: 'GET',
                                     path: double(spec: double(to_s: '/rails/info/properties')),
                                     defaults: { controller: 'rails/info', action: 'properties' })

    # Set the return value for the routes call
    allow(routes_double).to receive(:routes).and_return([route1, route2, internal_route])
  end

  after do
    # Clean up the generated CSV file
    FileUtils.rm_f(csv_file)
  end

  it 'creates a routes.csv file with the correct headers and data' do
    # Run the rake task
    rake['routes:csv'].invoke

    expect(File.exist?(csv_file)).to be(true)

    # Verify the CSV content
    csv_content = CSV.read(csv_file)
    expect(csv_content[0]).to eq(['Prefix', 'Verb', 'URI Pattern', 'Controller#Action'])
    expect(csv_content[1]).to eq(['users', 'GET', '/users', 'users#index'])
    expect(csv_content[2]).to eq(['new_user', 'GET', '/users/new', 'users#new'])

    # Verify that the internal route was not included
    expect(csv_content.size).to eq(3)
  end
end
