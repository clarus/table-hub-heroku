Table-Hub-Heroku
================
The Rails application deployed on https://www.table-hub.com/. It is running on [Heroku](https://www.heroku.com/) with the name `beyond-afternoon`.

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