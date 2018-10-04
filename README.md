# MEGAPHONE

Megaphone is used to advertise service updates to specific slack channels.

## Setup:

### API Key:

Megaphone uses Figaro to obscure the API key used. To setup this app to prepare for use:

1. `bundle install`
1. `bundle exec figaro install`
1. Add your API key to `/config/application.yml` as `fastly_api_key:`

### Database:

At this time, there is no database used in this project.

## Where the App is Now:

This app can send a ping to Fastly when the user clicks the `Ping Fastly` link. It retrieves a list of all Fastly services that have been updated in the interval provided.

## Future Plans:

- Process the list of services
  - Only grab services changes that are active
  - Save changes in the database to show previous version and current version
- Send secondary ping to Fastly to grab a diff of the previous version to the current version
- Process the diff
  - Only save actual differences to db
- Connect customer IDs to Slack channels
- Push updated services diffs to the appropriate Slack channel
- Format Slack post?
