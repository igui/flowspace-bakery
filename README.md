Flowspace Bakery
================

Flowspace Bakery is an artisanal digital bakery, crafting the finest digital cookies in New York City.

We don't mass produce our cookies in faceless factories. Instead, We bake cookies to order, one at a time.


Set up docker
-------------

Run docker-compose to start the Redis and PostgreSQL containers in the background.

```bash
$ docker-compose up --detach
```

Running the application
-----------------------

To run the application we have to start the Rails server and Sidekiq

```bash
bundle exec rails db:setup
bundle exec rails server  
bundle exec sidekiq       # In another terminal
```

Then open the browser at http://localhost:3000. HTTP Auth access is: bake / somecookies

Test Suite
----------
Like most bakeries, Flowspace Bakery has a test suite. The full suite can be run with:

```bash
$ RAILS_ENV=test bundle exec db:create
$ bundle exec rspec spec
```

Requirements
-------------

This application requires:

- Ruby 2.7.1
- Docker
- docker-compose

Similar Projects
----------------
[Momofuku milk bar](http://milkbarstore.com/)
