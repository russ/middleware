require "spec"
require "../src/middleware"

alias EnvType = Hash(String, Array(String))

class PushHandler
  include Middleware::Handler

  def initialize(@to_add : String)
  end

  def call(env : EnvType)
    env["result"] << @to_add
    call_next(env)
  end
end

class AppendPrependA
  include Middleware::Handler

  def call(env : EnvType)
    env["result"] << "A"
    call_next(env)
    env["result"] << "A"
  end
end

class AppendPrependB
  include Middleware::Handler

  def call(env : EnvType)
    env["result"] << "B"
    call_next(env)
    env["result"] << "B"
  end
end
