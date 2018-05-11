module Middleware
  module Handler
    property next : Handler | Nil

    abstract def call(env)

    def call_next(env)
      if next_handler = @next
        next_handler.call(env)
      else
        env
      end
    end
  end
end
