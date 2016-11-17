# Rack::AccessRemoteAssets

Rack::AccessRemoteAssets is a Rack middleware, *for Rails apps*, which can beautify your local development. Imagine you take a database dump from your staging or production machine and import it into your development database to be able to work with real data. All the uploaded images will then be missing (like `/system/images/uploads/original/0000/x/y/z.jpg`).

This middleware takes over the requests for images missing on your filesystem and requests them from a given remote uri.

## Installation

Add this line to your application's Gemfile:

    gem 'rack-access_remote_assets'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-access_remote_assets

For Rails, add this to your `application.rb`:

``` ruby
require "access_remote_assets"
config.middleware.insert_after(
  Rack::ETag,
  AccessRemoteAssets,
  uri: "https://example.com"
)
```

The uri attribute can be written with http basic auth if your staging server sits behind a login. If you can write an url, and your browser can display the image (without any login sessions), than you can provide it to this middleware.

## Usage

The middleware only works in Rails and Rails development environments. Every request that includes the path "/system/images" and requests a(n image) file that is not present on your local machine, will be *temporarily* redirected (307) to the given uri.

*Example:*  

A request for `http://localhost:3000/system/images/uploads/catfight.jpg`, where the file `catfight.jpg` is not present at `public/system/images/uploads/catfight.jpg` will result in a 307-redirect to `http://example.com/system/images/uploads/catfight.jpg`

## Disclaimer

I built it, because I was annoyed of missing images on my machine after importing a db dump from production. I know not many people actually do this but I had this use case. It worked great for me, but I can imagine many scenarios where it could break. I don't have (any/extensive <- depending on when you find this...) test coverage so maybe it won't work in your setup the way it does in mine.  

I am open to issues and pull requests.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
