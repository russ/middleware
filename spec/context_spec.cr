require "./spec_helper"

class ContextA
  property foo : String

  def initialize(@foo : String)
  end
end

class ContextAHandler
  include Middleware::Handler

  def call(context)
    context
  end
end

class ContextAProcessor
  def initialize(@context : ContextA)
  end

  def process!
    Middleware::Builder.new(middleware).call(@context)
  end

  private def middleware : Array(ContextAHandler)
    [
      ContextAHandler.new,
    ] of ContextAHandler
  end
end

class ContextB
  property bar : String

  def initialize(@bar : String)
  end
end

class ContextBHandler
  include Middleware::Handler

  def call(context)
    context
  end
end

class ContextBProcessor
  def initialize(@context : ContextB)
  end

  def process!
    Middleware::Builder.new(middleware).call(@context)
  end

  private def middleware : Array(ContextBHandler)
    [
      ContextBHandler.new,
    ] of ContextBHandler
  end
end

describe Middleware::Builder do
  context "dealing with multiple middleware stacks in the same app" do
    it "doesn't break" do
      ContextAProcessor.new(ContextA.new("foo")).process!
      ContextBProcessor.new(ContextB.new("bar")).process!
    end
  end
end
