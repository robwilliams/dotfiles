gem_group :development, :test do 
  gem 'rspec-rails'
end
generate('rspec:install')

gem_group :development do 
  gem 'thin'
end

run 'mv config/database.yml config/database.yml.example'
run 'rm public/index.html'

git :init
git add: '.'

append_file '.gitignore' do
  "config/database.yml\n"
end

git commit: '-am \'Initial Commit\''

if bootstrap_selected = yes?('Would you like to use Twitter Bootstrap?')

  gem 'anjlab-bootstrap-rails', version: '>= 2.0', require: 'bootstrap-rails'

  create_file 'app/assets/stylesheets/app_bootstrap.css.scss' do
<<-CSS
// override any variable in this file to customise bootstrap
// https://github.com/anjlab/bootstrap-rails/blob/master/vendor/twitter/scss/variables.scss

// import original bootstrap
@import "bootstrap";
@import "responsive";
CSS
  end

  inject_into_file('app/assets/stylesheets/application.css', 
                   after: ' *= require_self') do 
    "\n *= require app_bootstrap"
  end

  inject_into_file('app/assets/javascripts/application.js', 
                   after: '//= require jquery_ujs') do 
<<JS

// Include all twitter's javascripts
//= require bootstrap
// Or pick any of them yourself
// require bootstrap-transition
// require bootstrap-alert
// require bootstrap-modal
// require bootstrap-dropdown
// require bootstrap-scrollspy
// require bootstrap-tab
// require bootstrap-tooltip
// require bootstrap-popover
// require bootstrap-button
// require bootstrap-collapse
// require bootstrap-carousel
// require bootstrap-typeahead
JS
  end

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
