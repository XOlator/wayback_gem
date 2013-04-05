require 'helper'

describe Wayback::Client do

  subject do
    Wayback::Client.new
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
          :endpoint => 'http://tumblr.com/',
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

  describe "#connection" do
    it "looks like Faraday connection" do
      expect(subject.send(:connection)).to respond_to(:run_request)
    end
    it "memoizes the connection" do
      c1, c2 = subject.send(:connection), subject.send(:connection)
      expect(c1.object_id).to eq c2.object_id
    end
  end

end
