gem 'compass-rails', group: :assets
gem 'foreman', require: false, group: :development
gem 'rspec-rails', group: [:development, :test]
gem 'shoulda-matchers', group: :test

run 'bundle:install'
generate 'rspec:install'

application do
  %Q{
    config.generators do |g|
      g.test_framework  :rspec, fixture: false
      g.view_specs      false
      g.helper_specs    false
      g.fixture_replacement false
    end
  }
end

remove_dir 'doc'
remove_file 'README.rdoc'
remove_file 'public/index.html'
create_file 'README.md'
create_file 'Procfile', "web: bundle exec rails server -p $PORT"
run 'mv config/database.yml config/database.yml.example'
append_file '.gitignore', 'config/database.yml'

git :init
git add: '.'
git commit: "-m 'Initial Commit'"

run 'cp config/database.yml.example config/database.yml'
