require "./spec_helper"

describe Middleware::Builder do
  context "basic `use`" do
    it "should add items to the stack and make them callable" do
      data = {} of String => String

      proc = ->(env : Hash(String, String)) { env["data"] = "foobar"; env }

      instance = Middleware::Builder(Proc(Hash(String, String), Hash(String, String)), Hash(String, String)).new
      instance.use(proc)
      instance.call(data)

      data["data"].should eq("foobar")
    end

    it "should be able to add multiple items" do
      data = {} of String => String

      proc1 = ->(env : Hash(String, String)) { env["one"] = "foobar"; env }
      proc2 = ->(env : Hash(String, String)) { env["two"] = "barfoo"; env }

      instance = Middleware::Builder(Proc(Hash(String, String), Hash(String, String)), Hash(String, String)).new
      instance.use(proc1)
      instance.use(proc2)
      instance.call(data)

      data["one"].should eq("foobar")
      data["two"].should eq("barfoo")
    end
  end
end
