# Katalog
__The place to share and work on ideas and side-projects__

Katalog is a side-projects and ideas tracking web app. It allows your development team to suggest ideas for side-project, discuss about them, and kickstart them into live projects.

## Setup

Katalog requires several environment variables to be set in order to work.

__Rails secret key base__

* `RAILS_SECRET_KEY_BASE` - Use `rake secret` to generate a value for this variable.

__Github Application Credentials__

Set up a new Github application under your account and add these corresponding environment variables:

* `GITHUB_KEY` - The app public key.
* `GITHUB_SECRET` - The app secret key.

__Github User Credentials__

A single Katalog app only allows users of a certain Github organization to sign in, Katalog requires the name of that organization:

* `AUTHORIZED_GITHUB_ORGANIZATION` - The name of the authorized Github organization.

__AWS Credentials__

The Katalog app requires an AWS S3 account for image uploading:

* `KATALOG_AWS_ID` - AWS access key id.
* `KATALOG_AWS_ACCESS_KEY` - AWS secret access key id.
* `KATALOG_AWS_BUCKET_NAME` - The S3 bucket the images will be uploaded to.

__Look-and-feel__

If you wish to edit the look-and-feel of Katalog, feel free to edit the images and `en.yml` files.

## Post a project by e-mail

You can create a project from email if you configure an app in postmarkapp.com, 
and map it's inbound web hook to `http://host/postmark`
In order to test this feature you can do one of two things:

* A curl POST command similar to this:

``` 
  curl -X POST "127.0.0.1/postmark" \
  {
    "From" : "sender@example.com",
    "To" : "receiver@example.com",
    "Cc" : "copied@example.com",
    "Bcc": "blank-copied@example.com",
    "Subject" : "Test",
    "Tag" : "Invitation",
    "HtmlBody" : "<b>Hello</b>",
    "TextBody" : "Hello",
    "ReplyTo" : "reply@example.com",
    "Headers" : [{ "Name" : "CUSTOM-HEADER", "Value" : "value" }]
  }
```
* Setup an account on `https://postmarkapp.com` and configure the inbound hook URL 
  to `http://<HOST>/postmark`. Note that postmarkapp.com will need access to
  your server, so this can be a bit tricky to test in development.

## Version
0.9

## License

Katalog is available under the MIT license. See the LICENSE file for more info.
