require "./spec_helper"

describe Middleware::Builder do
  context "basic `use`" do
    it "should add items to the stack and make them callable" do
      env = { "result" => [] of String }

      instance = Middleware::Builder.new(PushHandler.new("foobar"))
      instance.call(env)

      env["result"].first.should eq("foobar")
    end

    it "should be able to add multiple items" do
      env = { "result" => [] of String }

      instance = Middleware::Builder.new([
        PushHandler.new("foobar"),
        PushHandler.new("barfoo")
      ])
      instance.call(env)

      env["result"].first.should eq("foobar")
      env["result"].last.should eq("barfoo")
    end
  end

  it "should call classes in the proper order" do
    env = { "result" => [] of String }

    instance = Middleware::Builder.new([
      AppendPrependA.new,
      AppendPrependB.new
    ])
    instance.call(env)

    (env["result"] == ["A", "B", "B", "A"]).should eq(true)
  end
end
