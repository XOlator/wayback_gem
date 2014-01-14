# Wayback Gem

[![Gem Version](https://badge.fury.io/rb/wayback.png)][gem]
[![Build Status](https://secure.travis-ci.org/XOlator/wayback_gem.png?branch=master)][travis]
[![Coverage Status](https://coveralls.io/repos/XOlator/wayback_gem/badge.png?branch=master)][coveralls]

[gem]: https://rubygems.org/gems/wayback
[travis]: http://travis-ci.org/XOlator/wayback_gem
[coveralls]: https://coveralls.io/r/XOlator/wayback_gem


A Ruby interface to Archive.org's Wayback Machine Memento API.

## Installation
    gem install wayback

## Quick Start Guide
Accessing the Wayback Machine is super-duper easy.

```ruby
require 'wayback'
Wayback.page('http://www.xolator.com', :first)
```


## Documentation
You can browse the Rdoc [here][documentation].

[documentation]: http://rdoc.info/github/XOlator/wayback_gem/master/frames


## Configuration

There is no real configuration necessary for accessing the Wayback Machine Memento API, however you can change endpoint and other basic connection options.

The current defaults configurations for this gem are:

```ruby
Wayback.configure do |c|
  c.endpoint = 'http://web.archive.org'
  c.endpoint_path = '/web'
  c.json_endpoint = 'http://archive.org'
  c.json_endpoint_path = '/wayback'
  c.connection_options = {
    :headers  => {:user_agent => "Wayback Ruby Gem #{Wayback::Version}"},
    :request  => {:open_timeout => 5, :timeout => 10},
    :ssl      => {:verify => false},
  }
  c.identiy_map = false
  c.middleware = Faraday::Builder.new do |builder|
    # Convert request params to "www-form-urlencoded"
    builder.use Faraday::Request::UrlEncoded
    # Follow redirects
    builder.use FaradayMiddleware::FollowRedirects
    # Handle 4xx server responses
    builder.use Wayback::Response::RaiseError, Wayback::Error::ClientError
    # Handle 5xx server responses
    builder.use Wayback::Response::RaiseError, Wayback::Error::ServerError
    # Parse closest available JSON result
    builder.use Wayback::Response::ParseAvailablity
    # Parse memento page
    builder.use Wayback::Response::ParseMementoPage
    # Parse link-format with custom memento parser
    builder.use Wayback::Response::ParseMemento
    # Set Faraday's HTTP adapter
    builder.adapter Faraday.default_adapter
  end
```


## Usage Examples

**Fetch the timeline of archived pages**

```ruby
Wayback.list('http://www.xolator.com')
```

**Fetch a specific archived page**

```ruby
Wayback.page('http://www.xolator.com', 20130613055153)
Wayback.page('http://www.xolator.com', :first)
Wayback.page('http://www.xolator.com', :last)
```


## Additional Notes
Based heavily on the [Twitter gem][twitter_gem]. (Xièxie!)

More information on Archive's Wayback Machine memento API can be found [here][wayback_api].

[twitter_gem]: https://www.github.com/sferik/twitter
[wayback_api]: http://mementoweb.org/depot/native/ia/


## Copyright
Copyright (c) 2013 [XOlator][xolator].
See [LICENSE][license] for details.

[xolator]: http://www.xolator.com
[license]: LICENSE.md
