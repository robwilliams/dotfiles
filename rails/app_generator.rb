gem_group :development, :test do 
  gem 'rspec-rails'
end
generate('rspec:install')

gem_group :development do 
  gem 'thin'
end

run 'mv config/database.yml config/database.yml.example'
run 'rm public/index.html'
run 'rm README.rdoc'
run 'touch README.md'

git :init
git add: '.'

append_file '.gitignore' do
  "config/database.yml\n"
end

git commit: '-am \'Initial Commit\''

if bootstrap_selected = yes?('Would you like to use Twitter Bootstrap?')

  gem 'twitter-bootstrap-rails'
  run 'bundle install'
  generate('bootstrap:install')
  git add: '.'
  git commit: '-m \'Added Twitter Bootstrap\''
end

if yes?("Do you want to install simple form?")
  gem 'simple_form'

  if bootstrap_selected
    generate('simple_form:install --bootstrap')
  else
    generate('simple_form:install')
  end

  git add: '.'
  git commit: '-m \'Added Simple Form\''
end

if yes?("Initialise the application?")
  run 'cp config/database.yml.example config/database.yml'
  rake('db:create')
  rake('db:migrate')
end
