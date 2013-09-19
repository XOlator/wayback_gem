require 'helper'

describe Wayback do

  after do
    Wayback.reset!
  end

  # N.B. IN SPEC, NOT USING http:// DUE TO PARSING ISSUE WITH DOUBLE BACKSLASH.

  context "when delegating to a client" do
    before do
      stub_get("/timemap/link/gleu.ch").to_return(:body => fixture("list.timemap"), :headers => {:content_type => "application/link-format"})
    end
  
    it "requests the correct resource" do
      Wayback.list('gleu.ch')
      expect(a_get("/timemap/link/gleu.ch")).to have_been_made
    end
  
    it "returns the same results as a client" do
      expect(Wayback.list('gleu.ch')).to eq Wayback::Client.new.list('gleu.ch')
    end
  end

  describe ".respond_to?" do
    it "delegates to Wayback::Client" do
      expect(Wayback.respond_to?(:list)).to be_true
    end
    it "takes an optional argument" do
      expect(Wayback.respond_to?(:client, true)).to be_true
    end
  end

  describe ".client" do
    it "returns a Wayback::Client" do
      expect(Wayback.client).to be_a Wayback::Client
    end
  
    context "when the options don't change" do
      it "caches the client" do
        expect(Wayback.client).to eq Wayback.client
      end
    end
  end

end
