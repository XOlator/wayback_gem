require 'helper'

describe Wayback::Error::ClientError do

  before do
    @client = Wayback::Client.new
  end

  Wayback::Error::ClientError.errors.each do |status, exception|
    [nil, "error"].each do |body|
      context "when HTTP status is #{status} and body is #{body.inspect}" do
        before do
          body_message = '<wayback><error><title>Hrm.</title><message>Wayback Machine doesn&apos;t have that page archived.</message></error></wayback>' unless body.nil?
          stub_get("/list/timemap/link/gleu.ch").to_return(:body => body_message, :status => status)
        end
        it "raises #{exception.name}" do
          expect{@client.list('gleu.ch')}.to raise_error exception
        end
      end
    end
  end

end
