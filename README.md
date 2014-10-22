# Omniauth::Garmin


## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-garmin'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-garmin

## Usage

Set the GARMIN_CALLBACK_URL environment variable for the callback location.
I.e. for local development, you'll want to use soemthing like: 
export GARMIN_CALLBACK_URL="http://127.0.0.1:3000/auth/garmin/callback"

In production, you'll want to replace this with your host environment. 

## Contributing

1. Fork it ( https://github.com/[my-github-username]/omniauth-garmin/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
