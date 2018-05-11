module Middleware
  class Builder(T, V)
    @stack : Array(T)

    def initialize
      @stack = [] of T
    end

    def use(middleware)
      @stack << middleware
    end

    def call(env = Nil)
      to_app.call(env)
    end

    private def to_app
      Runner(T, V).new(@stack)
    end
  end
end
