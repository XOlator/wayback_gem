require 'helper'

describe Wayback::Identity do

  describe "#initialize" do
    it "raises an ArgumentError when type is not specified" do
      expect{Wayback::Identity.new}.to raise_error ArgumentError
    end
  end

  context "identity map enabled" do
    before do
      Wayback.identity_map = Wayback::IdentityMap
    end

    after do
      Wayback.identity_map = false
    end

    describe ".fetch" do
      it "returns existing objects" do
        Wayback::Identity.store(Wayback::Identity.new(:id => 1))
        expect(Wayback::Identity.fetch(:id => 1)).to be
      end

      it "raises an error on objects that don't exist" do
        expect{Wayback::Identity.fetch(:id => 6)}.to raise_error Wayback::Error::IdentityMapKeyError
      end
    end
  end

  describe "#==" do
    it "returns true when objects IDs are the same" do
      one = Wayback::Identity.new(:id => 1, :screen_name => "gleuch")
      two = Wayback::Identity.new(:id => 1, :screen_name => "ohjia")
      expect(one == two).to be_true
    end
    it "returns false when objects IDs are different" do
      one = Wayback::Identity.new(:id => 1)
      two = Wayback::Identity.new(:id => 2)
      expect(one == two).to be_false
    end
    it "returns false when classes are different" do
      one = Wayback::Identity.new(:id => 1)
      two = Wayback::Base.new(:id => 1)
      expect(one == two).to be_false
    end
  end

end
