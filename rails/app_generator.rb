gem 'foreman', require: false, group: :development
gem 'dotenv-rails', require: false, group: [:development, :test]
run 'bundle:install'

remove_dir 'doc'
remove_file 'README.rdoc'
create_file 'README.md'
create_file 'Procfile', "web: bundle exec rails server -p $PORT"
run 'mv config/database.yml config/database.yml.example'
append_file '.gitignore', 'config/database.yml'

git :init
git add: '.'
git commit: "-m 'Initial Commit'"

run 'cp config/database.yml.example config/database.yml'
