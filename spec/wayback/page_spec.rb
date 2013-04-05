require 'helper'

describe Wayback::Page do

  describe "#==" do
    it "returns true when objects IDs are the same" do
      saved_search = Wayback::Page.new(:id => 1, :name => "foo")
      other = Wayback::Page.new(:id => 1, :name => "bar")
      expect(saved_search == other).to be_true
    end
    it "returns false when objects IDs are different" do
      saved_search = Wayback::Page.new(:id => 1)
      other = Wayback::Page.new(:id => 2)
      expect(saved_search == other).to be_false
    end
    it "returns false when classes are different" do
      saved_search = Wayback::Page.new(:id => 1)
      other = Wayback::Identity.new(:id => 1)
      expect(saved_search == other).to be_false
    end
  end

  describe "to_s" do
    it "returns string when valid" do
      html = Wayback::Page.new(:id => 1, :html => "foo").to_s
      expect(html.class == String).to be_true
      expect(html == "foo").to be_true
    end
    it "returns blank when no HTML" do
      html = Wayback::Page.new(:id => 1).to_s
      expect(html.class == String).to be_true
      expect(html == "").to be_true
    end
  end

end
