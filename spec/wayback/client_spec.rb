require 'helper'

describe Wayback::Client do

  subject do
    Wayback::Client.new(:consumer_key => "CK", :consumer_secret => "CS", :oauth_token => "OT", :oauth_token_secret => "OS")
  end

  context "with module configuration" do

    before do
      Wayback.configure do |config|
        Wayback::Configurable.keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    after do
      Wayback.reset!
    end

    it "inherits the module configuration" do
      client = Wayback::Client.new
      Wayback::Configurable.keys.each do |key|
        expect(client.instance_variable_get(:"@#{key}")).to eq key
      end
    end

    context "with class configuration" do

      before do
        @configuration = {
          :connection_options => {:timeout => 10},
          :endpoint => 'http://xolator.com/',
          :middleware => Proc.new{},
          :identity_map => ::Hash
        }
      end

      context "during initialization" do
        it "overrides the module configuration" do
          client = Wayback::Client.new(@configuration)
          Wayback::Configurable.keys.each do |key|
            expect(client.instance_variable_get(:"@#{key}")).to eq @configuration[key]
          end
        end
      end

      context "after initialization" do
        it "overrides the module configuration after initialization" do
          client = Wayback::Client.new
          client.configure do |config|
            @configuration.each do |key, value|
              config.send("#{key}=", value)
            end
          end
          Wayback::Configurable.keys.each do |key|
            expect(client.instance_variable_get(:"@#{key}")).to eq @configuration[key]
          end
        end
      end

    end
  end

  describe "#delete" do
    before do
      stub_delete("/custom/delete").with(:query => {:deleted => "object"})
    end
    it "allows custom delete requests" do
      subject.delete("/custom/delete", {:deleted => "object"})
      expect(a_delete("/custom/delete").with(:query => {:deleted => "object"})).to have_been_made
    end
  end

  describe "#put" do
    before do
      stub_put("/custom/put").with(:body => {:updated => "object"})
    end
    it "allows custom put requests" do
      subject.put("/custom/put", {:updated => "object"})
      expect(a_put("/custom/put").with(:body => {:updated => "object"})).to have_been_made
    end
  end

  describe "#post" do
    before do
      stub_post("/custom/post").with(:body => {:updated => "object"})
    end
    it "allows custom post requests" do
      subject.post("/custom/post", {:updated => "object"})
      expect(a_post("/custom/post").with(:body => {:updated => "object"})).to have_been_made
    end
  end

  describe "#connection" do
    it "looks like Faraday connection" do
      expect(subject.send(:connection)).to respond_to(:run_request)
    end
    it "memoizes the connection" do
      c1, c2 = subject.send(:connection), subject.send(:connection)
      expect(c1.object_id).to eq c2.object_id
    end
  end

  describe "#request" do
    it "catches Faraday errors" do
      subject.stub!(:connection).and_raise(Faraday::Error::ClientError.new("Oops"))
      expect{subject.send(:request, :get, "/path")}.to raise_error Wayback::Error::ClientError
    end
  end

end