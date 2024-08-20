# README

## Stack

- Ruby on Rails as the API framework
- Rspec test framework
- PostgreSQL as the database
- Jwt for authentication
- Alba for data serialization

* Ruby version
    3.1.0 

* Rails version
    7.1.3.4

## Managing Environment Variables

  Ensure you have a `.env` file where you store api keys (ipstack api key should be stored there) and other credentials below is what mine looks like

  ```
  IP_STACK_KEY='enter ipstack api key'
  POSTGRES_DB='enter db name'
  DATABASE_HOST='geolocation-db' # this is not necessarily a secret
  DATABASE_USER='enter your db username'
  DATABASE_PASSWORD='enter your db password'
  DATABASE_PORT='5432' # this is not necessarily a secret
  ```


## Setup in a minute (using Docker)
- Clone the repo

- Ensure you have docker installed and running (see https://www.docker.com/).

- Run the command in the root directory `docker-compose build`, this will download all the necessary images and dependencies.

- Run the command `docker-compose up` to start the services in the docker-compose file(rails, and postgresql).

- In a different terminal, run the command below.

- `docker-compose run web rails db:migrate`, this command will execute migration in dev environment.

- Run `docker-compose run web bundle exec rails db:seed` to seed data into the DB. 

- For testing db setup, run `docker-compose run web bundle exec rails db:create RAILS_ENV=test`

- On your browser, visit localhost:3000 to see the app in development.
 

## Application Setup(without Docker)

    Ensure you have Ruby 3.1.0 installed, then follow the steps below

    - Run `bundle install`
    - Run `rails db:create`
    - Run `rails db:migrate`
    - Run `rails db:seed` to seed data into the DB.
    - Run `rails s` to start the rails server on port 3000.


## Running Tests

- After the setup is complete, open a terminal in the root directory.
- Run `docker-compose run web bundle exec rspec`
- If you run into a migration error, run the command `docker-compose run web bundle exec rails db:migrate RAILS_ENV=test`, then try to run the test command again.


## Endpoints/Documentation

To see a brief list of endpoints and their information, open the file `endpoints.md`, the file can be found in the root directory of this app.


## Possible Improvements

- **Error Logging**

  In a production environment, a logger like Sentry is needed to report unexpected errors, this will ensure swift bug fixing.

- **Add Related Models**

  More models can be added to cover data such as `location, time_zone, currency` and other related data that are related to a Geolocation, for the sake of simplicity, I decided to implement a minimal/single
  model (Geolocation), the other models will have a one-to-one or one-to-many relationship with geolocation.

- **Use of Background Job and Webhook**

  Depending on the use case of the app, the call to retrieve and save Geolocation data can be done asynchronously, this will ensure a much better user experience, it can be implemented by using backend
  queues such as Good Job or Sidekiq (this requires redis). The webhook option available on ipstack is also a great way to ensure great user experience and less load on the server so that does not  
  continue to wait for a response from the third-party API.

- **More Specs**
    
  More specs can be written to cover at least 98% of the entire code, due to timing and my tight schedule this week, I was unable to write as much specs as I would have loved to.

- **Authentication**

 For the sake of simplicity, I decided to implement a jwt authentication by my self, this is because using a gem like devise will be adding a lot more than is needed 
 for a simple authentication. For a more robust and wholesome application, the use of `devise` and `devise-jwt` or any other proven token based authentication gem 
 should be preferred.
