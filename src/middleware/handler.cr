module Middleware
  module Handler(C)
    property next : Handler(C) | Nil

    abstract def call(env : C) : C

    def call_next(env : C)
      if next_handler = @next
        next_handler.call(env)
      else
        env
      end
    end
  end
end
