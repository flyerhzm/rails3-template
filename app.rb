gem "haml", ">= 3.0.13"
gem "compass", ">= 0.10.2"
gem "will_paginate", :git => "git://github.com/mislav/will_paginate.git", :branch => 'rails3'
gem 'authlogic', :git => 'git://github.com/odorcicd/authlogic.git', :branch => 'rails3'
gem "formtastic", :git => 'git://github.com/justinfrench/formtastic.git', :branch => 'rails3'
gem "has_scope", ">= 0.5.0"
gem "inherited_resources", ">= 1.1.2"
gem "exception_notification", :git => "git://github.com/rails/exception_notification.git"
gem "css_sprite", ">= 1.4.9"

gem "mongrel", :group => :development
gem "awesome_print", :require => 'ap', :group => :development

gem "autotest-rails", ">= 4.1.0", :group => :test
gem "rspec", ">= 2.0.0.beta.12", :group => :test
gem "rspec-rails", ">= 2.0.0.beta.12", :group => :test
gem "factory_girl_rails", ">= 1.0.0", :group => :test
gem "remarkable_activerecord", ">= 4.0.0.alpha2", :group => :test

gem "cucumber", :group => :cucumber
gem "cucumber-rails", :group => :cucumber
gem "capybara", :group => :cucumber
gem "database_cleaner", :group => :cucumber
gem "spork", :group => :cucumber
gem "launchy", :group => :cucumber
gem "pickle", :git => "git://github.com/codegram/pickle.git", :group => :cucumber

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
%html{:xmlns => "http://www.w3.org/1999/xhtml", "xml:lang" => "en", :lang => "en"}
  %head
    %title #{app_name}
    = stylesheet_link_tag 'compiled/screen', 'compiled/formtastic', 'compiled/formtastic_changes', :cache => true, :media => 'screen, projection'
    = stylesheet_link_tag 'compiled/print.css', :media => 'print'
    /[if IE]
      = stylesheet_link_tag 'compiled/ie.css', :media => 'screen, projection'
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
run "rm public/stylesheets/scaffold.css"

get "http://github.com/flyerhzm/rails3-template/raw/master/templates/app/controllers/home_controller.rb", "app/controllers/home_controller.rb"
get "http://github.com/flyerhzm/rails3-template/raw/master/templates/app/views/home/show.html.haml", "app/views/home/show.html.haml"
get "http://github.com/flyerhzm/rails3-template/raw/master/templates/spec/support/remarkable.rb", "spec/support/remarkable.rb"

file ".gitignore", <<-END
.DS_Store
.bundle
db/*.sqlite3
log/*.log
tmp/**/*
public/stylesheets/compiled/**
END
git :init
git :add => "."
git :commit => %Q(-am "build a rails3 app by flyerhzm's rails3-template")
