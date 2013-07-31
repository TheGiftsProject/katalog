# Katalog
__The place to share and work on ideas and side-projects__

Katalog is a side-projects and ideas tracking web app. It allows your development team to suggest ideas for side-project, discuss about them, and kickstart them into live projects.

---------------------

## Setup

Katalog requires several environment variables to be set in order to work.

__Rails secret key base__

* `RAILS_SECRET_KEY_BASE` - Use `rake secret` to generate a value for this variable.

__Github Application Credentials__

Set up a new Github application under your account and add these corresponding environment variables:

* `GITHUB_KEY` - The app public key.
* `GITHUB_SECRET` - The app secret key.

__Github User Credentials__

A single Katalog app only allows users of a certain Github organization to sign in. Katalog requires the credentials of a user with access to this organization:

* `GITHUB_USER` - The email of the Github user.
* `GITHUB_USER_TOKEN` - The oauth token of the Github user.
* `AUTHORIZED_GITHUB_ORGANIZATION` - The name of the authorized Github organization.

__AWS Credentials__

The Katalog app requires an AWS S3 account for image uploading:

* `KATALOG_AWS_ID` - AWS access key id.
* `KATALOG_AWS_ACCESS_KEY` - AWS secret access key id.

__Look-and-feel__

If you wish to edit the look-and-feel of Katalog, feel free to edit the images and `en.yml` files.

---------------------

## Version
0.1

---------------------

## License

Katalog is available under the MIT license. See the LICENSE file for more info.