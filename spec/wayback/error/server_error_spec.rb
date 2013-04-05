require 'helper'

describe Wayback::Error::ServerError do

  before do
    @client = Wayback::Client.new
  end

  Wayback::Error::ServerError.errors.each do |status, exception|
    context "when HTTP status is #{status}" do
      before do
        stub_get("/list/timemap/link/gleu.ch").to_return(:status => status)
      end
      it "raises #{exception.name}" do
        expect{@client.list('gleu.ch')}.to raise_error exception
      end
    end
  end

end
