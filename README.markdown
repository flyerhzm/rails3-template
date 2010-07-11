rails3-template
===============

rails3-template gathers a lot of useful plugins/gems to create a basic rails3 application.

Usage
-----

for rails 3.0.0.beta4

    rails new new_app http://github.com/flyerhzm/rails3-template/raw/master/app.rb
    cd new_app
    rake rails:template LOCATION=http://github.com/flyerhzm/rails3-template/raw/master/authlogic.rb

before rails 3.0.0.beta4

    rails new_app http://github.com/flyerhzm/rails3-template/raw/master/app.rb
    cd new_app
    rake rails:template LOCATION=http://github.com/flyerhzm/rails3-template/raw/master/authlogic.rb

Plugins/gems included
---------------------

haml
compass

will_paginate
formtastic

authlogic
inherited_resources
exception_notification

**development**
mongrel
awesome_print

**test**
autotest-rails
rspec
rspec-rails
factory_girl_rails
remarkable_activerecord

**cucumber**
cucumber
cucumber-rails
capybara
database_cleaner
spork
launchy
pickle
