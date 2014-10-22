# Katalog
__The place to manage your passion projects__
![logo](https://raw.githubusercontent.com/TheGiftsProject/katalog/master/app/assets/images/logo-big.png)

Katalog is a passion-projects and ideas tracking web app. It allows your development team to suggest ideas for side-project, discuss about them, and kickstart them into live projects.

## Setup

Katalog requires several environment variables to be set in order to work.

__Rails secret key base__

* `RAILS_SECRET_KEY_BASE` - Use `rake secret` to generate a value for this variable.

__Github Application Credentials__

Set up a new Github application under your account and add these corresponding environment variables:

* `GITHUB_KEY` - The app public key.
* `GITHUB_SECRET` - The app secret key.

__AWS Credentials__

The Katalog app requires an AWS S3 account for image uploading:

* `KATALOG_AWS_ID` - AWS access key id.
* `KATALOG_AWS_ACCESS_KEY` - AWS secret access key id.
* `KATALOG_AWS_BUCKET_NAME` - The S3 bucket the images will be uploaded to.

## Version

0.5.1

## License

Katalog is available under the MIT license. See the LICENSE file for more info.
