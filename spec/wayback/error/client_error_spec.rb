require 'helper'

describe Wayback::Error::ClientError do

  before do
    @client = Wayback::Client.new
  end

  Wayback::Error::ClientError.errors.each do |status, exception|
    # [nil, "error", "errors"].each do |body|
    #   context "when HTTP status is #{status} and body is #{body.inspect}" do
    #     before do
    #       body_message = '{"' + body + '":"Client Error"}' unless body.nil?
    #       stub_get("/1.1/statuses/user_timeline.json").with(:query => {:screen_name => 'gleuch'}).to_return(:status => status, :body => body_message)
    #     end
    #     it "raises #{exception.name}" do
    #       expect{@client.user_timeline('gleuch')}.to raise_error exception
    #     end
    #   end
    # end
  end

end
