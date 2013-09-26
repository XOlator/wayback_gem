require 'helper'

describe Wayback::API::Archive do

  before do
    @client = Wayback::Client.new
  end

  # N.B. IN SPEC, NOT USING http:// DUE TO PARSING ISSUE WITH DOUBLE BACKSLASH.

  describe "#list" do
    before do
      stub_get("/timemap/link/gleu.ch").to_return(:body => fixture("list.timemap"), :headers => {:content_type => "application/link-format"})
    end
    it "requests the correct resource" do
      @client.list('gleu.ch')
      expect(a_get("/timemap/link/gleu.ch")).to have_been_made
    end
    it "returns the link data" do
      timemap = @client.list('gleu.ch')
      expect(timemap).to be_a Wayback::Archive
      expect(timemap.id).to eq ('http://gleu.ch')
      expect(timemap.first_date).to eq(20110417182251)
      expect(timemap.first_date?).to be_true
    end
  end

  describe "#page" do
    before do
      stub_get("/20130129170322/gleu.ch").to_return(:body => fixture("page.html"), :headers => {:content_type => "text/html"})
    end

    it "requests the correct resource" do
      @client.page('gleu.ch', 20130129170322)
      expect(a_get("/20130129170322/gleu.ch")).to have_been_made
    end

    it "returns the desired page on date" do
      stub_get("/20130129170322/gleu.ch").to_return(:body => fixture("page.html"), :headers => {:content_type => "text/html"})

      page = @client.page('gleu.ch', 20130129170322)
      expect(page).to be_a Wayback::Page
      expect(page.html).to match /^\<\!DOCTYPE html\>.*http\:\/\/gleu\.ch.*\<\/html\>/im
    end

    it "returns the first desired page" do
      stub_get("/0/gleu.ch").to_return(:body => fixture("page.html"), :headers => {:content_type => "text/html"})

      page = @client.page('gleu.ch', :first)
      expect(page).to be_a Wayback::Page
      expect(page.html).to match /^\<\!DOCTYPE html\>.*http\:\/\/gleu\.ch.*\<\/html\>/im
    end

    it "returns the last desired page" do
      stub_get("/#{Time.now.strftime('%Y%m%d%H%M%S')}/gleu.ch").to_return(:body => fixture("page.html"), :headers => {:content_type => "text/html"})

      page = @client.page('gleu.ch', :last)
      expect(page).to be_a Wayback::Page
      expect(page.html).to match(/^\<\!DOCTYPE html\>.*http\:\/\/gleu\.ch.*\<\/html\>/im)
    end

    it "returns the desired page for Time" do
      stub_get("/#{Time.now.strftime('%Y%m%d%H%M%S')}/gleu.ch").to_return(:body => fixture("page.html"), :headers => {:content_type => "text/html"})

      page = @client.page('gleu.ch', Time.now)
      expect(page).to be_a Wayback::Page
      expect(page.html).to match(/^\<\!DOCTYPE html\>.*http\:\/\/gleu\.ch.*\<\/html\>/im)
    end

    it "returns the desired page for Date" do
      stub_get("/#{Time.parse(Date.today.to_s).strftime('%Y%m%d%H%M%S')}/gleu.ch").to_return(:body => fixture("page.html"), :headers => {:content_type => "text/html"})

      page = @client.page('gleu.ch', Date.today)
      expect(page).to be_a Wayback::Page
      expect(page.html).to match(/^\<\!DOCTYPE html\>.*http\:\/\/gleu\.ch.*\<\/html\>/im)
    end

    it "returns the desired page for DateTime" do
      stub_get("/#{Time.parse(DateTime.new(2013,1,1).to_s).strftime('%Y%m%d%H%M%S')}/gleu.ch").to_return(:body => fixture("page.html"), :headers => {:content_type => "text/html"})

      page = @client.page('gleu.ch', DateTime.new(2013,1,1))
      expect(page).to be_a Wayback::Page
      expect(page.html).to match(/^\<\!DOCTYPE html\>.*http\:\/\/gleu\.ch.*\<\/html\>/im)
    end

    it "returns the desired page for String" do
      stub_get("/#{Time.now.strftime('%Y%m%d%H%M%S')}/gleu.ch").to_return(:body => fixture("page.html"), :headers => {:content_type => "text/html"})

      page = @client.page('gleu.ch', Time.now.to_s)
      expect(page).to be_a Wayback::Page
      expect(page.html).to match(/^\<\!DOCTYPE html\>.*http\:\/\/gleu\.ch.*\<\/html\>/im)
    end

    it "returns the desired page for Fixnum" do
      stub_get("/#{Time.now.strftime('%Y%m%d%H%M%S')}/gleu.ch").to_return(:body => fixture("page.html"), :headers => {:content_type => "text/html"})
      page = @client.page('gleu.ch', Time.now.to_i)
      expect(page).to be_a Wayback::Page
      expect(page.html).to match(/^\<\!DOCTYPE html\>.*http\:\/\/gleu\.ch.*\<\/html\>/im)
    end

    it "returns the desired page for Float" do
      stub_get("/#{Time.now.strftime('%Y%m%d%H%M%S')}/gleu.ch").to_return(:body => fixture("page.html"), :headers => {:content_type => "text/html"})
      page = @client.page('gleu.ch', Time.now.to_f)
      expect(page).to be_a Wayback::Page
      expect(page.html).to match(/^\<\!DOCTYPE html\>.*http\:\/\/gleu\.ch.*\<\/html\>/im)
    end

    [[0], {:a => 'b'}, File].each do |t|
      it "returns error for #{t.class}" do
        expect{page = @client.page('gleu.ch', t)}.to raise_error(Wayback::Error::ClientError)
      end
    end
  end

end
