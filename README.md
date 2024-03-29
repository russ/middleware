[![GitHub release](https://img.shields.io/github/release/russ/middleware.svg)](https://github.com/russ/middleware/releases)
[![Build Status](https://travis-ci.org/russ/middleware.svg?branch=master)](https://travis-ci.org/russ/middleware)

# Middleware

Middleware is a library which provides a generalized implementation of the chain of responsibility pattern for Crystal.

This is heavily based on HTTP stdlib and inspiration from https://github.com/Ibsciss/ruby-middleware

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  middleware:
    github: russ/middleware
```

## Usage

```crystal
require "middleware"
```

```
class PushHandler
  include Middleware::Handler(String)

  def initialize(@to_add : String)
  end

  def call(env : EnvType) : String
    env["result"] << @to_add
    call_next(env)
  end
end

context = { "result" => [] of String }
instance = Middleware::Builder.new([
  PushHandler.new("foobar"),
  PushHandler.new("barfoo")
] of Middleware::Handler(String))
instance.call(context)
```

`{ "result" => ["foobar", "barfoo"] }`

## Contributing

1. Fork it ( https://github.com/russ/Middleware/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [russ](https://github.com/russ) Russ Smith - creator, maintainer
