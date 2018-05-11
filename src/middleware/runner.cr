module Middleware
  class Runner(T, V)
    @stack : Array(T)
    # @kickoff : T

    def initialize(@stack : Array(T))
      # @kickoff = build_call_chain(stack)
      build_call_chain(stack)
    end

    def call(env)
      # @kickoff.call(env)
    end

    def build_call_chain(stack : Array(T))
      raise T.new.inspect
      # empty_proc = T.new { |env| env }
      # @stack.reverse.reduce(empty_proc) do |next_middleware, current_middleware|

      #   ->(env : V) {
      #     current_middleware.call(env)
      #     next_middleware.call(env)
      #   }
      # end
    end
  end
end
