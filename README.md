# HipchatExceptionNotifier

## Installation

Add this line to your application's Gemfile:

    gem 'hipchat_exception_notifier'

And then execute:

    $ bundle

Add to your environment file:

```ruby
require "hipchat_exception_notifier"
config.middleware.use "HipchatExceptionNotifier",
  token: "...token...",
  room_name: "...room name...",
  user: "Notifier",
  announce: false
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
