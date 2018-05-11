module Middleware
  class Builder(EnvType)
    @handler : Handler

    # Creates a new builder with the *handlers* array as handler chain.
    def self.new(handlers : Array(Handler))
      new(Middleware::Builder.build_call_chain(handlers))
    end

    def initialize(@handler : Handler)
    end

    def call(env = Nil)
      @handler.call(env)
    end

    def self.build_call_chain(handlers, last_handler : (EnvType ->)? = nil)
      raise ArgumentError.new "You must specify at least one HTTP Handler." if handlers.empty?
      0.upto(handlers.size - 2) { |i| handlers[i].next = handlers[i + 1] }
      handlers.last.next = last_handler if last_handler
      handlers.first
    end
  end
end
