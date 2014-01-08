Table-Hub-Heroku
================

Setup
-----
Install Ruby 2.1.0 and run:

    gem install bundler
    bundle install
    bundle exec rake db:migrate

To launch the server:

    rails s

To update it online:

    git push heroku master