# Katalog

## Setup

Katalog requires several environment variables to be set in order to work.

### Rails secret key base

* `RAILS_SECRET_KEY_BASE` - Use `rake secret` to generate a value for this variable.

### Github Application Credentials

Set up a new Github application under your account and add these corresponding environment variables:

* `GITHUB_KEY` - The app public key.
* `GITHUB_SECRET` - The app secret key.


### Github User Credentials

A single Katalog app only allows users of a certain Github organization to sign in. Katalog requires the credentials of a user with access to this organization:

* `GITHUB_USER` - The email of the Github user.
* `GITHUB_USER_TOKEN` - The oauth token of the Github user.
* `AUTHORIZED_GITHUB_ORGANIZATION` - The name of the authorized Github organization.


### AWS Credentials

The Katalog app requires an AWS S3 account for image uploading:

* `KATALOG_AWS_ID` - AWS access key id.
* `KATALOG_AWS_ACCESS_KEY` - AWS secret access key id.


## Version
0.1

## License

Katalog is available under the MIT license. See the LICENSE file for more info.