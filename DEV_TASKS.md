# Development Tasks

- [x] **Initialize the Gem:** Use `bundler` to generate a standard directory structure for the new gem, `rails_routes_csv`.
- [x] **Define Dependencies:** Specify the necessary dependencies in the `rails_routes_csv.gemspec` file. This gem will need `railties` to integrate with Rails.
- [x] **Create the Rake Task:** Create a Rake task in `lib/tasks/routes.rake`. This task will contain the logic to:
  - [x] Access all the application's routes.
  - [x] Format the route information (verb, path, controller, action, prefix).
  - [x] Generate a CSV file named `routes.csv` in the root of the Rails application.
- [x] **Integrate with Rails:** Use a `Railtie` to automatically load the new Rake task into any Rails application that includes the gem.
- [ ] **Documentation:** Write a `README.md` to explain how to install and use the gem.
  - [x] Correct missing documentation in `rails_routes_csv.gemspec`
- [ ] **Ergonomics:**
  - [ ] Configure Rubocop
  - [ ] add pre-commit hooks
    - [ ] For Rubocop
- [ ] **Testing:** Set up a testing framework and write tests to ensure the Rake task works as expected.
  - [ ] Set up CI in GitHub
    - [ ] Run test suite
    - [ ] Run Rubocop