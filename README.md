# MEGAPHONE

Megaphone is used to advertise service updates to specific slack channels.

## Setup:

### API Key:

Megaphone uses Figaro to obscure the API key used. To setup this app to prepare for use:

1. `bundle install`.
1. `bundle exec figaro install`.
1. Add your API key to `/config/application.yml` as `fastly_api_key:`.
1. Run `travis encrypt fastly_api_key="whatever your api key is" --add` in your terminal. This will add an encrypted value to your travis.yml file so your tests can run and pass.

### Database:

There are 2 tables in the database, `Customers` and `Services`.

* `Customers` details the customers who have been actively updating their services.
* `Services` tracks updated services, including service name, service ID, active version number, and previous version number.

## Where the App is Now:

This app can send a ping to Fastly when the user clicks the `Ping Fastly` link. It retrieves a list of all Fastly services that have been updated in the interval provided. Then, the app saves the list of services that are currently active to the database to be available for future consideration.

## Future Plans:

- [] Process the list of services
  - [] Only grab services changes that are active
  - [x] Save changes in the database to show previous version and current version
- [] Send secondary ping to Fastly to grab a diff of the previous version to the current version
- [] Process the diff
  - [] Only save actual differences to db
- [] Connect customer IDs to Slack channels
- [] Push updated services diffs to the appropriate Slack channel
- [] Format Slack post?
