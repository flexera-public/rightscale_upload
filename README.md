# RightscaleUpload

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'rightscale_upload'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rightscale_upload

## Usage

Include the RightScale Upload package in your cookbook's Gemfile:

    gem 'rightscale_upload', :github => 'rightscale/rightscale_upload'

You should also create a RightScale Upload configuration file in your home directory ~/.rightscale_upload.json:

    {
        "fog": {
            "provider": "AWS",
            "aws_access_key_id": YOUR_AWS_ACCESS_KEY_ID,
            "aws_secret_access_key": YOUR_AWS_SECRET_ACCESS_KEY,
            "region": "us-west-1"
        },
        "container": "devs-us-west"
    }

You will need to put an actual AWS access key ID and secret access key.

Next, run the upload command:

    > bundle install
    > bundle exec rightscale_upload berkshelf upload
      ...
      Uploaded to: https://myawesomecookbook.s3-us-west-1.amazonaws.com/1.0.0.tar.gz

You can then import all cookbooks into the RightScale system using this URL.

## Thor support

You can also add RightScale Upload to your Thorfile (if you have one):

    require 'rightscale_upload'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
