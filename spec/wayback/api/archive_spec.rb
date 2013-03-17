require 'helper'

describe Wayback::API::Archive do

  before do
    @client = Wayback::Client.new
  end

  # N.B. IN SPEC, NOT USING http:// DUE TO PARSING ISSUE WITH DOUBLE BACKSLASH.

  describe "#list" do
    before do
      stub_get("/list/timemap/link/gleu.ch").to_return(:body => fixture("list.timemap"), :headers => {:content_type => "application/link-format"})
    end
    it "requests the correct resource" do
      @client.list('gleu.ch')
      expect(a_get("/list/timemap/link/gleu.ch")).to have_been_made
    end
    it "returns the link data" do
      timemap = @client.list('gleu.ch')
      expect(timemap).to be_a Wayback::Archive
      expect(timemap.id).to eq ('http://gleu.ch')
    end
  end

  describe "#page" do
    before do
      stub_get("/memento/20130129170322/gleu.ch").to_return(:body => fixture("page.html"), :headers => {:content_type => "text/html"})
    end
    it "requests the correct resource" do
      @client.page('gleu.ch', 20130129170322)
      expect(a_get("/memento/20130129170322/gleu.ch")).to have_been_made
    end
    it "returns the desired page on date" do
      page = @client.page('gleu.ch', 20130129170322)
      expect(page).to be_a Wayback::Page
      expect(page.html).to match /^\<\!DOCTYPE html\>.*http\:\/\/gleu\.ch.*\<\/html\>/im
    end
    it "returns the first desired page" do
      stub_get("/memento/0/gleu.ch").to_return(:body => fixture("page.html"), :headers => {:content_type => "text/html"})
      page = @client.page('gleu.ch', :first)
      expect(page).to be_a Wayback::Page
      expect(page.html).to match /^\<\!DOCTYPE html\>.*http\:\/\/gleu\.ch.*\<\/html\>/im
    end
    it "returns the last desired page" do
      stub_get("/memento/#{Time.now.to_i}/gleu.ch").to_return(:body => fixture("page.html"), :headers => {:content_type => "text/html"})
      page = @client.page('gleu.ch', :last)
      expect(page).to be_a Wayback::Page
      expect(page.html).to match(/^\<\!DOCTYPE html\>.*http\:\/\/gleu\.ch.*\<\/html\>/im)
    end
    it "returns the desired page for Time" do
      stub_get("/memento/#{Time.now.to_i}/gleu.ch").to_return(:body => fixture("page.html"), :headers => {:content_type => "text/html"})
      page = @client.page('gleu.ch', Time.now)
      expect(page).to be_a Wayback::Page
      expect(page.html).to match(/^\<\!DOCTYPE html\>.*http\:\/\/gleu\.ch.*\<\/html\>/im)
    end
    it "returns the desired page for Time string" do
      stub_get("/memento/#{Time.now.to_i}/gleu.ch").to_return(:body => fixture("page.html"), :headers => {:content_type => "text/html"})
      page = @client.page('gleu.ch', Time.now.to_s)
      expect(page).to be_a Wayback::Page
      expect(page.html).to match(/^\<\!DOCTYPE html\>.*http\:\/\/gleu\.ch.*\<\/html\>/im)
    end
  end

end
