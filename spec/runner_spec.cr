require "./spec_helper"

class Handler
end

class A < Handler
  def call(env : Hash(String, Array(String)))
    env["result"] << "A"
    @app.call(env)
    env["result"] << "A"
  end
end

class B < Handler
  def call(env : Hash(String, Array(String)))
    env["result"] << "B"
    @app.call(env)
    env["result"] << "B"
  end
end

describe Middleware::Runner do
  # it "should work with an empty stack" do
  #   instance = Middleware::Runner(Proc(Hash(String, String), Hash(String, String)), Hash(String, String)).new([
  #     ->(env : Hash(String, String)) { env["data"] = "foobar"; env }
  #   ])
  #   instance.call({} of String => String)
  # end

  it "should call classes in the proper order" do
    # proc1 = ->(env : Hash(String, Array(String))) {
    #   env["result"] << "A"; env
    # }

    # proc2 = ->(env : Hash(String, Array(String))) {
    #   env["result"] << "B"; env
    # }

    env = { "result" => [] of String }
    instance = Middleware::Runner(Handler.class, Hash(String, Array(String))).new([
      A, B
    ])
    instance.call(env)
    (env["result"] == ["A", "A", "B", "B"]).should eq(true)
  end
end
