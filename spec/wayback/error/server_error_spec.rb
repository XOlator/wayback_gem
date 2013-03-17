require 'helper'

describe Wayback::Error::ServerError do

  before do
    @client = Wayback::Client.new
  end

  Wayback::Error::ServerError.errors.each do |status, exception|
    # context "when HTTP status is #{status}" do
    #   before do
    #     stub_get("/1.1/statuses/user_timeline.json").with(:query => {:screen_name => 'gleuch'}).to_return(:status => status)
    #   end
    #   it "raises #{exception.name}" do
    #     expect{@client.user_timeline('gleuch')}.to raise_error exception
    #   end
    # end
  end

end
