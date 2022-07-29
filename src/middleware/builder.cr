module Middleware
  class Builder(T)
    @handler : T

    # Creates a new builder with the *handlers* array as handler chain.
    def self.new(handlers : Array(T))
      new(Middleware::Builder.build_call_chain(handlers))
    end

    def initialize(@handler : T)
    end

    def call(env = Nil)
      @handler.call(env)
    end

    def self.build_call_chain(handlers)
      raise ArgumentError.new "You must specify at least one handler." if handlers.empty?
      0.upto(handlers.size - 2) { |i| handlers[i].next = handlers[i + 1] }
      handlers.first
    end
  end
end
