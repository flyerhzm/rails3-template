gem "haml", ">= 3.0.13"
gem "authlogic", ">= 2.1.5"
gem "formtastic", ">= 1.0.0.beta"
gem "inherited_resources", ">= 1.1.2"
gem "exception_notification", :git => "git://github.com/rails/exception_notification.git"

gem "factory_girl_rails", ">= 1.0.0", :group => :test
gem "rspec-rails", ">= 2.0.0.beta.12", :group => :test
gem "cucumber-rails", ">= 0.3.2", :group => :test

generators = <<-GENERATORS
  config.generators do |g|
    g.template_engine :haml
    g.test_framework :rspec, :fixture => true, :views => false
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
    %title #{app_name.humanize}
    = stylesheet_link_tag :all
    = javascript_include_tag :defaults
    = csrf_meta_tag
  %body
    = yield
LAYOUT

remove_file "public/index.html"
remove_file "public/images/rails.png"

create_file "log/.gitkeep"
create_file "tmp/.gitkeep"

git :init
git :add => "."

docs = <<-DOCS

Run the following commands to complete the setup of #{app_name.humanize}:

% cd #{app_name}
% gem install bundler
% bundle install
% bundle lock
% script/rails generate rspec:install

DOCS

log docs
