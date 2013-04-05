# Wayback Gem - IN DEVELOPMENT

Currently at 93.34% coverage.

[gem]: https://rubygems.org/gems/wayback

A Ruby interface to Archive.org's Wayback Machine Memento API.

## Installation
    gem install wayback

## Quick Start Guide
So you want to get up and tweeting as fast as possible?


## Documentation
COMING SOON! -- [http://rdoc.info/gems/wayback][documentation]

[documentation]: http://rdoc.info/gems/wayback



## Configuration
COMING SOON

## Usage Examples

**Fetch the timeline of archived pages**

```ruby
Wayback.list('http://www.xolator.com')
```

**Fetch a specific archived page**

```ruby
Wayback.page('http://www.xolator.com', 1363488758)
Wayback.page('http://www.xolator.com', :first)
Wayback.page('http://www.xolator.com', :last)
```


## Additional Notes
Based heavily on the [Twitter gem](https://www.github.com/sferik/twitter). (Thanks dudes!)
More information on Archive's Wayback Machine memento API can be found at ____.



## Copyright
Copyright (c) 2013 XOlator.
See [LICENSE][] for details.

[license]: LICENSE.md
