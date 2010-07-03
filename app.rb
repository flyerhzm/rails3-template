gem "haml", ">= 3.0.13"
gem "compass", ">= 0.10.2"
gem "will_paginate", :git => "git://github.com/mislav/will_paginate.git", :branch => 'rails3'
gem 'authlogic', :git => 'git://github.com/odorcicd/authlogic.git', :branch => 'rails3'
gem "formtastic", :git => 'git://github.com/justinfrench/formtastic.git', :branch => 'rails3'
gem "inherited_resources", ">= 1.1.2"
gem "exception_notification", :git => "git://github.com/rails/exception_notification.git"

gem "mongrel", :group => :development

gem "autotest-rails", ">= 4.1.0", :group => :test
gem "factory_girl_rails", ">= 1.0.0", :group => :test
gem "capybara", :group => :test
gem "database_cleaner", :group => :test
gem "cucumber-rails", :group => :test
gem "cucumber", :group => :test
gem "rspec-rails", ">= 2.0.0.beta.12", :group => :test
gem "rspec", ">= 2.0.0.beta.12", :group => :test
gem "spork", :group => :test
gem "launchy", :group => :test
gem "pickle", :git => "git://github.com/codegram/pickle.git", :group => :test

generators = <<-GENERATORS
  config.generators do |g|
      g.template_engine :haml
      g.test_framework :rspec, :fixture => false, :views => false
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end
GENERATORS

application generators

get "http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js",  "public/javascripts/jquery.js"
get "http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/jquery-ui.min.js", "public/javascripts/jquery-ui.js"
get "http://github.com/rails/jquery-ujs/raw/master/src/rails.js", "public/javascripts/rails.js"

jquery = <<-JQUERY
module ActionView::Helpers::AssetTagHelper
  remove_const :JAVASCRIPT_DEFAULT_SOURCES
  JAVASCRIPT_DEFAULT_SOURCES = %w(jquery.js jquery-ui.js rails.js)

  reset_javascript_include_default
end
JQUERY

initializer "jquery.rb", jquery

layout = <<-LAYOUT
!!!
%html
  %head
    %title #{app_name}
    = stylesheet_link_tag "compiled/screen", "compiled/formtastic", :cache => true
    = javascript_include_tag :defaults
    = csrf_meta_tag
  %body
    - if !current_user
      = link_to "Register", new_account_path
      = link_to "Log In", new_user_session_path
    - else
      = link_to "My Account", account_path
      = link_to "Logout", user_session_path, :method => :delete, :confirm => "Are you want to logout?"

    .flash
      - flash.each do |type, message|
        .message{:class => type}
          %p= message
    .container
      = yield
LAYOUT

remove_file "app/views/layouts/application.html.erb"
create_file "app/views/layouts/application.html.haml", layout

remove_file "public/index.html"
remove_file "public/images/rails.png"

create_file "log/.gitkeep"
create_file "tmp/.gitkeep"

run "bundle install"
generate "formtastic:install"
generate "rspec:install"
generate "cucumber:install --rspec --capybara"
generate "pickle:skeleton --path --email"
run "compass init rails . --css-dir=public/stylesheets/compiled  --sass-dir=app/stylesheets --using blueprint"
run "sass-convert public/stylesheets/formtastic.css app/stylesheets/formtastic.scss"
run "sass-convert public/stylesheets/formtastic_changes.css app/stylesheets/formtastic_changes.scss"
run "rm public/stylesheets/formtastic.css"
run "rm public/stylesheets/formtastic_changes.css"

get "http://github.com/flyerhzm/rails3-template/raw/master/templates/app/controllers/home_controller.rb", "app/controllers/home_controller.rb"
get "http://github.com/flyerhzm/rails3-template/raw/master/templates/app/views/home/show.html.haml", "app/views/home/show.html.haml"

git :init
git :add => "."

docs = <<-DOCS

Run the following commands to complete the setup of #{app_name}:

% cd #{app_name}

# compass
% compass init rails . --using blueprint/semantic

DOCS

log docs
