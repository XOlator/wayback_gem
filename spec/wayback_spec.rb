require 'helper'

describe Wayback do

  after do
    Wayback.reset!
  end

  # context "when delegating to a client" do
  # 
  #   before do
  #     stub_get("/1.1/statuses/user_timeline.json").with(:query => {:screen_name => "gleuch"}).to_return(:body => fixture("statuses.json"), :headers => {:content_type => "application/json; charset=utf-8"})
  #   end
  # 
  #   it "requests the correct resource" do
  #     Wayback.user_timeline('gleuch')
  #     expect(a_get("/1.1/statuses/user_timeline.json").with(:query => {:screen_name => "gleuch"})).to have_been_made
  #   end
  # 
  #   it "returns the same results as a client" do
  #     expect(Wayback.user_timeline('gleuch')).to eq Wayback::Client.new.user_timeline('gleuch')
  #   end
  # 
  # end
  # 
  # describe ".respond_to?" do
  #   it "delegates to Wayback::Client" do
  #     expect(Wayback.respond_to?(:user)).to be_true
  #   end
  #   it "takes an optional argument" do
  #     expect(Wayback.respond_to?(:client, true)).to be_true
  #   end
  # end
  # 
  # describe ".client" do
  #   it "returns a Wayback::Client" do
  #     expect(Wayback.client).to be_a Wayback::Client
  #   end
  # 
  #   context "when the options don't change" do
  #     it "caches the client" do
  #       expect(Wayback.client).to eq Wayback.client
  #     end
  #   end
  #   context "when the options change" do
  #     it "busts the cache" do
  #       client1 = Wayback.client
  #       Wayback.configure do |config|
  #         config.consumer_key = 'abc'
  #         config.consumer_secret = '123'
  #       end
  #       client2 = Wayback.client
  #       expect(client1).not_to eq client2
  #     end
  #   end
  # end
  # 
  # describe ".configure" do
  #   Wayback::Configurable.keys.each do |key|
  #     it "sets the #{key.to_s.gsub('_', ' ')}" do
  #       Wayback.configure do |config|
  #         config.send("#{key}=", key)
  #       end
  #       expect(Wayback.instance_variable_get(:"@#{key}")).to eq key
  #     end
  #   end
  # 
  #   context "when invalid credentials are provided" do
  #     it "raises a ConfigurationError exception" do
  #       expect {
  #         Wayback.configure do |config|
  #           config.consumer_key = [12345, 54321]
  #           config.consumer_secret = 'valid_data'
  #         end
  #       }.to raise_exception(Wayback::Error::ConfigurationError)
  #     end
  #   end
  # 
  #   context "when no credentials are provided" do
  #     it "does not raise an exception" do
  #       expect {
  #         Wayback.configure do |config|
  #           config.consumer_key = nil
  #           config.consumer_secret = nil
  #           config.oauth_token = nil
  #           config.oauth_token_secret = nil
  #         end
  #       }.to_not raise_exception(Wayback::Error::ConfigurationError)
  #     end
  #   end
  # end
  # 
  # describe ".credentials?" do
  #   it "returns true if all credentials are present" do
  #     Wayback.configure do |config|
  #       config.consumer_key = 'CK'
  #       config.consumer_secret = 'CS'
  #       config.oauth_token = 'OT'
  #       config.oauth_token_secret = 'OS'
  #     end
  #     expect(Wayback.credentials?).to be_true
  #   end
  #   it "returns false if any credentials are missing" do
  #     Wayback.configure do |config|
  #       config.consumer_key = 'CK'
  #       config.consumer_secret = 'CS'
  #       config.oauth_token = 'OT'
  #     end
  #     expect(Wayback.credentials?).to be_false
  #   end
  # end

end
